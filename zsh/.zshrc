# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

#if [$OSTYPE == "linux-gnu"] ; then
#  source "$HOME/.zprofile"
#fi

# added by eihcek kechie
# add ~/bin to path if directory exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

#Rust environment
if [ -x $HOME/.cargo/env ]; then
. "$HOME/.cargo/env"
fi

# Nodejs
#VERSION=v20.11.0
VERSION=v20.11.1
DISTRO=linux-x64
export PATH=$HOME/.local/bin/node-$VERSION-$DISTRO/bin:$PATH

# Open JDK 11 (needed for React Native)
JDK11VERSION=11.0.21\+9
JD11KDISTRO=linux-x64
JDK17VERSION=17.0.9\+9
JDK17DISTRO=linux-x64
export PATH=$HOME/.local/bin/jdk-$JDK17VERSION/bin:$PATH

# Android Environment variables
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools


#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# TODO: check if homebrew is installed
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users//zsh-completions
zinit light zsh-users//zsh-autosuggestions
#zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git

# COLOR_LS as documented from zinit wiki
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# Load completions
autoload -Uz compinit && compinit

# TODO: look for a good color combo
# export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:*.tar=1;31:*.gz=1;31:*.tbz2=1;31*.tar=1;31:*.tgz=1;31:*.arj=1;31:*.taz=1;31:*.lzh=1;31:*.lzma=1;31:*.tlz=1;31:*.txz=1;31:*.zip=1;31:*.z=1;31:*.Z=1;31:*.dz=1;31:*.gz=1;31:*.lz=1;31:*.xz=1;31:*.bz2=1;31:*.bz=1;31:*.tbz=1;31:*.tbz2=1;31:*.tz=1;31:*.deb=1;31:*.rpm=1;31:*.jar=1;31:*.war=1;31:*.ear=1;31:*.sar=1;31:*.rar=1;31:*.ace=1;31:*.zoo=1;31:*.cpio=1;31:*.7z=1;31:*.rz=1;31"
# enable color support of ls and also add handy aliases
# taken from ~/.bashrc
# if [ -x /usr/bin/dircolors ]; then
#   #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#   test -r ~/.dir_colors/dircolors && eval "$(dircolors -b ~/.dir_colors/dircolors)" || eval "$(dircolors -b)"
#   alias ls='ls --color=auto'
#   alias dir='dir --color=auto'
#   alias vdir='vdir --color=auto'
#   alias grep='grep --color=auto'
#   alias fgrep='fgrep --color=auto'
#   alias egrep='egrep --color=auto'
# fi

if [ -x /opt/homebrew/bin/eza ]; then
  alias ls='eza --color=auto'
fi

alias vpslogin='ssh eihcek_at_vps'

# TODO bindkeys for MacOS
### ctrl+arrows
#bindkey "\e[1;5C" forward-word
#bindkey "\e[1;5D" backward-word

# urxvt
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

# oh my posh themes TODO: check for  homebrew executable as well
if [ -x $HOME/.local/bin/oh-my-posh ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.cache/oh-my-posh/themes/iterm2.omp.json)"
fi

#if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#  eval "$(oh-my-posh init zsh)"
#fi