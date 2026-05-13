# Agent Instructions for davidask/.dotfiles

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles. Most top-level directories are symlinked to the home directory.

## Architecture & Management

- **Management**: `stow` links directories to `$HOME`. Settings are defined in `stow/.stowrc`.
- **Bootstrap**: Run `./bootstrap` to link or restow all components.
- **Dependencies**: Run `./install` to install Homebrew dependencies via `.Brewfile`.

## Toolchain & Workflow

### Apple Platform Development
Custom scripts in `bin/` provide a CLI-first workflow for Apple platforms:
- `xc-init <Scheme>`: Generates `buildServer.json` for `sourcekit-lsp`. Required for Neovim/Helix LSP support in Swift projects.
- `xc-run <Scheme> [--watch]`: Builds and runs the app on the first booted simulator.
- `xc-clean [--force]`: Cleans Xcode `DerivedData` and caches.

### Editors
- **Neovim**: Configured in `nvim/.config/nvim`. Uses `lazy.nvim` for plugin management.
- **Helix**: Configured in `helix/`.

### Shell & Environment
- **Zsh**: Uses `zimfw`. Configuration in `zsh/`.
- **Themes**: Use `bin/sync-*-theme` scripts to synchronize appearance across Ghostty, Helix, Zellij, and OpenCode.

## Key Paths
- `nvim/.config/nvim`: Neovim configuration.
- `opencode/.config/opencode`: OpenCode specialized environment and configuration.
- `zsh/`: Zsh startup files (`.zshrc`, `.zshenv`, `.zimrc`).

## Constraints
- **Avoid Manual Symlinks**: Always use `stow` or the `./bootstrap` script.
- **Path Resolution**: When editing, remember that files in the repo are often nested (e.g., `nvim/.config/nvim/init.lua` becomes `~/.config/nvim/init.lua`).
- **Binary Scripts**: Prefer using scripts in `bin/` for project-specific operations (theme syncing, Apple builds).
