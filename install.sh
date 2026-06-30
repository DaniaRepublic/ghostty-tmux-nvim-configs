#!/usr/bin/env bash
# install.sh — set up tmux + Neovim (LazyVim) on Ubuntu 24.04.
# Idempotent: safe to re-run. Run as a normal user with sudo access, from inside the repo.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_MIN="0.11.2"
log() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }

backup() { if [ -e "$1" ] && [ ! -L "$1" ]; then mv "$1" "$1.bak.$(date +%s)"; fi; }

# 1) Base packages (always installed)
log "Installing base packages"
sudo apt-get update
sudo apt-get install -y \
  git curl wget unzip tar gzip build-essential \
  tmux ncurses-term \
  ripgrep fd-find \
  python3 python3-pip python3-venv

# 2) fd shim (Ubuntu installs the binary as 'fdfind')
mkdir -p "$HOME/.local/bin"
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  ln -sfn "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac

# 2b) fzf from upstream — apt's 0.44.1 is too old for fzf-lua's `transform` action (needs >= 0.45)
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
else
  git -C "$HOME/.fzf" pull --ff-only || true
fi
"$HOME/.fzf/install" --bin                              # downloads latest fzf binary to ~/.fzf/bin (no rc edits)
ln -sfn "$HOME/.fzf/bin/fzf" "$HOME/.local/bin/fzf"    # ~/.local/bin is already first on PATH

# 3) Node.js (NodeSource LTS) — TS/JSON/Tailwind/Solidity LSPs, prettier, markdownlint,
#    and markdown-preview's build step all need it
if ! command -v node >/dev/null 2>&1; then
  log "Installing Node.js 22.x"
  curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

# 4) Neovim >= 0.11.2 (apt is too old) — official prebuilt tarball
need_nvim=1
if command -v nvim >/dev/null 2>&1; then
  cur="$(nvim --version | sed -n '1s/.*v//p' | cut -d- -f1)"
  if [ -n "$cur" ] && [ "$(printf '%s\n%s\n' "$NVIM_MIN" "$cur" | sort -V | head -n1)" = "$NVIM_MIN" ]; then
    need_nvim=0
  fi
fi
if [ "$need_nvim" -eq 1 ]; then
  log "Installing latest stable Neovim"
  case "$(uname -m)" in
    x86_64)  asset="nvim-linux-x86_64" ;;
    aarch64) asset="nvim-linux-arm64"  ;;
    *) echo "Unsupported arch: $(uname -m)" >&2; exit 1 ;;
  esac
  tmp="$(mktemp -d)"
  curl -fsSL -o "$tmp/nvim.tar.gz" \
    "https://github.com/neovim/neovim/releases/latest/download/${asset}.tar.gz"
  sudo rm -rf "/opt/${asset}"
  sudo tar -C /opt -xzf "$tmp/nvim.tar.gz"
  sudo ln -sfn "/opt/${asset}/bin/nvim" /usr/local/bin/nvim
  rm -rf "$tmp"
fi

# 5) Link Neovim config into ~/.config/nvim
log "Linking Neovim config"
mkdir -p "$HOME/.config/nvim"
for f in init.lua lua lazyvim.json .markdownlint.yaml .neoconf.json stylua.toml; do
  if [ -e "$REPO_DIR/$f" ]; then
    backup "$HOME/.config/nvim/$f"
    ln -sfn "$REPO_DIR/$f" "$HOME/.config/nvim/$f"
  fi
done

# 6) tmux config at the XDG path (keeps TPM + plugins under ~/.config/tmux/plugins)
log "Linking tmux config"
mkdir -p "$HOME/.config/tmux"
# a stray ~/.tmux.conf shadows the XDG config (tmux prefers it) — back it up so ours is used
if [ -e "$HOME/.tmux.conf" ] && [ "$(readlink -f "$HOME/.tmux.conf" 2>/dev/null)" != "$(readlink -f "$REPO_DIR/.tmux.conf" 2>/dev/null)" ]; then
  log "~/.tmux.conf shadows the XDG config — backing it up"
  backup "$HOME/.tmux.conf"
fi
backup "$HOME/.config/tmux/tmux.conf"
ln -sfn "$REPO_DIR/.tmux.conf" "$HOME/.config/tmux/tmux.conf"

# 7) TPM + tmux plugins (tmux-sensible, tmux-kanagawa)
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
else
  git -C "$HOME/.config/tmux/plugins/tpm" pull --ff-only || true
fi
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.config/tmux/plugins"
"$HOME/.config/tmux/plugins/tpm/bin/install_plugins" \
  || log "TPM headless install hiccup — start tmux and press 'Ctrl-b + I' to finish"
if [ ! -d "$HOME/.config/tmux/plugins/tmux-kanagawa" ]; then
  log "tmux-kanagawa not installed — open tmux and press 'Ctrl-b' then 'I', then restart tmux"
fi

# 8) Neovim plugins (headless). LSP/formatter/linter binaries install via Mason on
#    first interactive launch (node + python are already present for that).
log "Syncing Neovim plugins"
nvim --headless "+Lazy! sync" +qa || true

log "Done. Start a shell, run 'tmux', and open 'nvim' once so Mason finishes installing"
log "LSPs/tools. Verify with :Mason and :checkhealth inside nvim."
