# set $PATH and $EDITOR here not in $HOME/.zshrc
# custom prompt and plugins goes there not here
os_type=$(uname -s)

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

if [[ "$os_type"  == "Darwin" ]]; then
  # MacOS Homebrew
  if [ -d /opt/homebrew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
# Android Environment variables MacOS
  export ANDROID_HOME=$HOME/Library/Android/Sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

if [[ "$os_type"  == "Linux" ]]; then
# linux homebrew
  if [ -d "$HOME/../linuxbrew/.linuxbrew/bin" ] ; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
# Android Environment variables linux
  export ANDROID_HOME=$HOME/Android/Sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools
# Nodejs Linux
  VERSION=v20.11.0
  VERSION=v20.11.1
  DISTRO=linux-x64
  export PATH=$HOME/.local/bin/node-$VERSION-$DISTRO/bin:$PATH
# Open JDK 11 (needed for React Native)
  JDK11VERSION=11.0.21\+9
  JD11KDISTRO=linux-x64
  JDK17VERSION=17.0.9\+9
  JDK17DISTRO=linux-x64
  export PATH=$HOME/.local/bin/jdk-$JDK17VERSION/bin:$PATH
fi

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
