# debian or maybe some distros doesn't read .zprofile
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  source "$HOME/.zprofile"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

#zinit ice depth=1; zinit light romkatv/powerlevel10k

# big three zsh plugins 
zinit light-mode for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions

#zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git

# COLOR_LS as documented from zinit wiki
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# Use modern completion system
autoload -Uz compinit && compinit

#history options
#
HISTSIZE=3000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase

setopt appendhistory sharehistory hist_ignore_space histignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# ### ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# # urxvt
#bindkey "\eOc" forward-word
#bindkey "\eOd" backward-word

### ctrl+delete
#bindkey "\e[3;5~" kill-word
# urxvt
#bindkey "\e[3^" kill-word

### ctrl+backspace
#bindkey '^H' backward-kill-word

### ctrl+shift+delete
#bindkey "\e[3;6~" kill-line
# urxvt
#bindkey "\e[3@" kill-line

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# TODO:
# make oh my posh work in apple terminal as well
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#  eval "$(oh-my-posh init zsh)"
  eval "$(oh-my-posh init zsh --config $HOME/.cache/oh-my-posh/themes/iterm2.omp.json)"
fi

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/richardalhama/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
