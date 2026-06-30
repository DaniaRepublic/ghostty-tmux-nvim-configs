# My ghostty, tmux and nvim configs symlinked under one repo.

## Remote setup (Ubuntu 24.04)

On the server:

    git clone https://github.com/DaniaRepublic/ghostty-tmux-nvim-configs.git ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh

Then start `tmux` and open `nvim` once so Mason finishes installing LSPs/tools.

Notes:
- Neovim is installed from the official tarball to /opt (apt's nvim is too old for LazyVim,
  which needs >= 0.11.2).
- `ghostty-config` is Mac-only and is not used on the server; your local Ghostty already
  drives the remote tmux over SSH (cmd+b = prefix, etc.).
- Clipboard uses OSC 52 — yanks in tmux/nvim land in your local clipboard over SSH with no
  extra tools. Do not install xclip/xsel on a headless box.
- Languages set up: Node + Python. To add Rust/Scala/Zig later: install the toolchain
  (`rustup` + `rustup toolchain install nightly`; JDK + Coursier; zig + zls) and enable the
  extra with `:LazyExtras`. `lua/plugins/formatting.lua` formats Rust via
  `rustup run nightly rustfmt`, so Rust formatting needs the nightly toolchain.
- Config lives at `~/.config/tmux/tmux.conf` and `~/.config/nvim/*` as symlinks into the
  cloned repo, so `git pull` updates everything in place.

> Note: when pushing so the server can clone, push a commit whose tracked files hold real
> content (the default `HEAD` does). The repo's working tree on the Mac uses symlinks into
> `~/.config/...`; avoid committing those symlink type-changes, or a clone on Linux would get
> links pointing at `/Users/...`. Commit specific files rather than `git add -A`.
