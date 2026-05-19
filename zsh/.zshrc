# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
 if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
 fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# History timestamp date format
HIST_STAMPS="dd-mm-yyyy"

# Which plugins to load
plugins=(
	git
	jump
	zsh-autosuggestions
	zsh-fzf-history-search
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Sonar-Scanner
export PATH="$PATH:/opt/sonar-scanner/bin"

# Go
export PATH="$PATH:/usr/local/go/bin"

# Neovim
export PATH="$PATH:/opt/nvim-linux65/bin"
export GIT_EDITOR=nvim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source fzf
source <(fzf --zsh)

# zsh-fzf-history-search
ZSH_FZF_HISTORY_SEARCH_BIND='^r'

# Alias
alias ezsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias j=jump
alias c=clear
alias tf=terraform
alias n=nvim
alias elua="nvim ~/.config/nvim/init.lua"
alias bat=batcat
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

hcat() {
  xdg-open "https://http.cat/$1"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# pnpm
export PNPM_HOME="/home/jmplourde/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.local/bin:$PATH"
