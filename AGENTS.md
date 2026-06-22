# Agent Instructions for davidask/.dotfiles

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles.

## Management & Setup
- **Bootstrap**: Run `./bootstrap` to link or restow all components. NEVER manually symlink files.
- **Dependencies**: Run `./install` to sync Homebrew dependencies.

## Toolchain & Workflow
- **Apple Development**: 
  - `xc-init <Scheme>`: Generates `buildServer.json` for `sourcekit-lsp`. **Mandatory** for Neovim/Helix LSP support in Swift.
  - `xc-run <Scheme> [--watch]`: Builds/runs on the first booted simulator.
  - `xc-clean`: Cleans `DerivedData` and caches.
- **Themes**: Use `bin/sync-*-theme` scripts to synchronize appearance across Ghostty, Helix, Zellij, and OpenCode.
- **OpenCode**: Configuration and specialized agent/skill logic reside in `.opencode/`.
- **Agents**: Agent skills and configuration in `~/.agents/` are stowed via the `agents` package.

## Constraints
- **Path Resolution**: Files in the repo are often nested (e.g., `nvim/.config/nvim/init.lua` is linked to `~/.config/nvim/init.lua`). Always check target paths relative to `$HOME`.
- **Scripts**: Prefer binary scripts in `bin/` for specialized tasks over manual tool execution.
- **Git**: Never commit autonomously; always ask the user for confirmation before performing git commit operations.
