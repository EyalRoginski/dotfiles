# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with GNU Stow. Each top-level directory (`nvim`, `shell`, `gdb`, `alacritty`) is a Stow package whose contents mirror `$HOME`, so `nvim/.config/nvim/init.lua` is linked to `~/.config/nvim/init.lua`. There is no build step, test suite, or linter.

Edits to tracked files take effect immediately through the symlinks. A new file only needs restowing if its parent directory is not already a symlink into this repo.

## Commands

```sh
stow -n -v -t "$HOME" nvim shell gdb alacritty   # dry run: check for conflicts
stow -R -t "$HOME" <package>                     # restow a package
nvim --headless -c 'qa'                          # check that the Neovim config loads without errors
nvim --headless '+Lazy! sync' +qa                # update plugins (rewrites lazy-lock.json, which is tracked)
```

## Platforms

The config has to work on both NixOS and Fedora, so platform differences are handled by runtime checks instead of separate files. Keep new platform-specific behaviour conditional in the same way:

- `shell/.zshrc` checks for `/etc/NIXOS`, because `~/.oh-my-zsh` is a read-only link into the Nix store there.
- `shell/.tmux.conf` uses `wl-copy` if available and `xclip` otherwise.
- The LSP configs check for executables: `nixd` is only enabled if installed, and `omnisharp.lua` handles the Nix binary name `OmniSharp`.

No Nix or home-manager configuration lives in this repo. On NixOS, the themes that `alacritty.toml` imports come from home-manager rather than from here.

## Neovim

`init.lua` loads `lua/roginski/init.lua`, which loads the keymaps, options and autocmds, bootstraps lazy.nvim, and declares all plugins in a single `require("lazy").setup` call.

- **Plugin configuration:** simple plugins are configured inline in the lazy spec. Larger ones are configured in `after/plugin/<name>.lua`, which runs after the plugins load.
- **Adding an LSP server:** add `vim.lsp.enable("<server>")` to `after/plugin/lsp.lua`. Server settings go in `after/lsp/<server>.lua`, which returns a table merged over the nvim-lspconfig defaults. The file is optional.
- **Portable mode:** setting `NVIM_PORTABLE=1` skips the `omnisharp` and `bashls` servers. The variable is read here but never set anywhere in this repo.

## Release workflow

Every push to `main` runs `.github/workflows/main.yml`, which force-moves the `latest` tag and publishes `nvim/.config/nvim` as `nvim-config.tar.gz` on the `Latest` GitHub release. Treat a push to `main` as a release of the Neovim config.
