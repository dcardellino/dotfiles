#
# .zshrc
#
# @author Dominic Cardellino
#

# oh-my-zsh Settings
# ---------------------------------------
# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh
# Set ZSH_THEME
ZSH_THEME="powerlevel10k/powerlevel10k"
# Enable oh-my-zsh plugins
plugins=(history-substring-search kubectl git terraform ansible helm docker zsh-autosuggestions)


# Terminal
# ---------------------------------------
export TERM=xterm-256color
export CLICOLOR=1
export CLICOLOR_FORCE=1

# History
# ---------------------------------------
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000

# Language and Locale
# ---------------------------------------
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Miscellaneous Settings
# ---------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export EDITOR="nvim"
export HOMEBREW_AUTO_UPDATE_SECS=604800


# Don't require escaping globbing characters in zsh.
# ---------------------------------------
unsetopt nomatch


# Add all known keys to the SSH agent
# ---------------------------------------
ssh-add -A 2>/dev/null;

# Export GNU CoreUtils
# ---------------------------------------
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  # gnubin; gnuman
  for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
  # I actually like that man grep gives the BSD grep man page
  #for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done
fi
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
# Custom $PATH with extra locations.
export PATH=$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/go/bin:/usr/local/git/bin:$PATH

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.aliases ]
then
  source ~/.aliases
fi

# Completions.
autoload -Uz compinit && compinit
# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Super useful Docker container oneshots.
# Usage: dockrun, or dockrun [centos7|fedora27|debian9|debian8|ubuntu1404|etc.]
dockrun() {
 docker run -it geerlingguy/docker-"${1:-ubuntu2004}"-ansible /bin/bash
}

# Enter a running Docker container.
function denter() {
 if [[ ! "$1" ]] ; then
     echo "You must supply a container ID or name."
     return 0
 fi

 docker exec -it $1 bash
 return 0
}

# Kubeconfig
export KUBECONFIG=~/.kube/config

# Golang
# ---------------------------------------
if [ -d $HOME/go ]; then
  export GOPATH="${HOME}/go"
  export GOROOT="$(brew --prefix golang)/libexec"
  export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
fi

#source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dcardellino/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dcardellino/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dcardellino/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dcardellino/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

source $ZSH/oh-my-zsh.sh
