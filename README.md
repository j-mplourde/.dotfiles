# dotfiles

Personal Linux dotfiles managed with a simple symlink script — no external tools required.

## Structure

Each tool has its own directory. Files inside mirror the path they should have under `$HOME`:

```
zsh/.zshrc                           -> ~/.zshrc
tmux/.tmux.conf                      -> ~/.tmux.conf
nvim/.config/nvim/init.lua           -> ~/.config/nvim/init.lua
lazygit/.config/lazygit/             -> ~/.config/lazygit/
librewolf/.librewolf/                -> ~/.librewolf/
claude/.claude/                      -> ~/.claude/
```

Only files whose path starts with `.` are linked, so `README.md` files inside tool directories are ignored.

## Installation

Clone the repo and run the install script:

```bash
git clone git@github.com:<your-username>/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh
```

The script will:
1. Symlink each dotfile into `$HOME` at the correct path
2. Back up any existing file that would be overwritten to `~/.dotfiles_backup/<timestamp>/`

## Adding a new dotfile

Say you want to track Neovim's config, which lives at `~/.config/nvim/init.lua` on your machine.

1. In the **repo**, create a matching directory for the tool:
   ```bash
   mkdir -p nvim/.config/nvim
   ```
2. Copy the file **from your machine** into the repo, keeping the same path relative to `$HOME`:
   ```bash
   cp ~/.config/nvim/init.lua nvim/.config/nvim/init.lua
   ```
3. Run the install script to replace the original file with a symlink back to the repo:
   ```bash
   bash install.sh
   ```

After this, `~/.config/nvim/init.lua` on your machine is a symlink to `nvim/.config/nvim/init.lua` in the repo. Edit either one and the change is reflected in both.

## Tools configured

| Tool | Config |
|------|--------|
| zsh | `.zshrc` with Oh My Zsh + Powerlevel10k |
| tmux | `.tmux.conf` |
| Neovim | `.config/nvim/init.lua` |
| lazygit | `.config/lazygit/` |
| Librewolf | `.librewolf/librewolf.overrides.cfg` |
| Claude Code | `.claude/` (agents, skills, commands, settings) |
| Calibre | `.config/calibre/` |

## Tools I use

Tools that aren't configured here but that I use daily, or that the dotfiles expect to be installed.

### Shell prerequisites

| Tool | Why |
|------|-----|
| [Homebrew](https://brew.sh) | Package manager; `.zshrc` loads `brew shellenv` |
| [Oh My Zsh](https://ohmyz.sh) | Plugins: `git`, `jump`, `zsh-autosuggestions`, `zsh-fzf-history-search`, `zsh-syntax-highlighting` |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Prompt theme |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder; `.zshrc` loads its shell integration |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting (aliased from `batcat`) |
| xclip | Backs the `pbcopy` / `pbpaste` aliases |

### Development

| Tool | Use |
|------|-----|
| git | Mostly through the Oh My Zsh git aliases (`gst`, `gcmsg`, `gco`, `ga`, `gp`…) |
| [Docker](https://www.docker.com) | Containers |
| [dive](https://github.com/wagoodman/dive) | Inspecting Docker image layers |
| make | Project task runner |
| [pnpm](https://pnpm.io) / [nvm](https://github.com/nvm-sh/nvm) | Node.js packages and versions |
| [uv](https://docs.astral.sh/uv/) | Python packages and environments |

### Cloud and infrastructure

| Tool | Use |
|------|-----|
| [AWS CLI](https://aws.amazon.com/cli/) | AWS operations |
| [Terragrunt](https://terragrunt.gruntwork.io) / [Terraform](https://www.terraform.io) | Infrastructure as code (`tf` alias) |

### Utilities

| Tool | Use |
|------|-----|
| [glow](https://github.com/charmbracelet/glow) | Rendering Markdown in the terminal |
| [ImageMagick](https://imagemagick.org) | Image conversion (`magick`) |
| htop | Process monitoring |

### Apps

| App | Use |
|-----|-----|
| [LibreWolf](https://librewolf.net) | Web browser (configured above) |
| [CopyQ](https://hluk.github.io/CopyQ/) | Clipboard manager |
| [Flameshot](https://flameshot.org) | Screenshots and annotation |
| [Parsec](https://parsec.app) | Remote desktop |
| [Obsidian](https://obsidian.md) | Notes |
| [OBS Studio](https://obsproject.com) | Screen recording and streaming |
| [Slack](https://slack.com) | Team chat |
