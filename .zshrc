#################
# meises .zshrc #
#################

HOSTNAME=`hostname -f`

zstyle ':completion:*' completer _complete
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*:processes' command 'ps fxo pid,user,cmd'
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# Menu for KILL
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
# Colors on completion me-ow
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

autoload -Uz compinit
compinit

# History configuration
HISTFILE=~/.zsh/zshhist
HISTSIZE=9000
SAVEHIST=900000000

# General options
setopt autocd beep nomatch notify share_history extendedglob
unsetopt appendhistory

# bash-style comment syntax
setopt interactivecomments

WORDCHARS='*?_-.[]~=&;!#$%^(){}'

# Load color variables
autoload colors zsh/terminfo

if [[ "$terminfo[colors]" -ge 8 ]]; then
 colors
fi

# Register terminal color variables for easy use
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE BLACK; do
  eval FG_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval FG_LIGHT_$color='%{$fg[${(L)color}]%}'
  eval BG_$color='%{$bg[${(L)color}]%}'
done

FG_NO_COLOR="%{$terminfo[sgr0]%}"

# If connected via ssh, display prompt in different color
if test -n "$SSH_CONNECTION"; then
  export PROMPT="$BG_RED${FG_LIGHT_WHITE}%n@%m$BG_BLACK:${FG_LIGHT_MAGENTA}%~${FG_LIGHT_GREEN}\$${FG_NO_COLOR} "
  export RPROMPT="$BG_RED${FG_LIGHT_WHITE}20%D %*${FG_NO_COLOR}"
else
  export PROMPT="${FG_LIGHT_GREEN}%n${FG_LIGHT_MAGENTA}@${FG_LIGHT_GREEN}%m:${FG_LIGHT_MAGENTA}%~${FG_LIGHT_YELLOW}\$${FG_NO_COLOR} "
  export RPROMPT='20%D %*'
fi

# Set colors for coreutils
if [ `uname` = 'Linux' ]; then
  eval "`dircolors -b`"
fi

# Colors in manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Key binding scheme
bindkey -e

# Bind special keys for xterm


case $TERM in
  (xterm*)
    bindkey '\eOH' beginning-of-line
    bindkey '\eOF' end-of-line
    bindkey '\e[3~' delete-char
    bindkey '\e[2~' overwrite-mode
    bindkey '\e[3;3~' delete-word
    ;;

  *)
    bindkey "^[[3~" delete-char
    ;;
esac

# Aliases
alias s='sudo'
alias ry='ruby'

if [ `uname` = 'Linux' ]; then
  alias ls='ls --color=auto'

  if test -e $HOME/.xinitrc; then
    source $HOME/.xinitrc
  fi
else
  alias ls='ls -G'
fi

alias l='ls -lh'
alias ll='ls -lah'
alias c='clear'
alias less='zless'
alias a='sudo aptitude'
alias sv='sudo service'
alias rh='rehash'
alias g='gem'
alias meld='env GTK2_RC_FILES=/usr/share/themes/Human/gtk-2.0/gtkrc meld'
alias tina='tmuxinator'

alias vipw='sudo vipw'
alias vigr='sudo vigr'
alias visudo='sudo visudo'

if [ `command -v vim` ]; then
  alias vi="vim"
fi

alias m='mosh'

alias ..1="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias ..5="cd ../../../../../"
alias ..6="cd ../../../../../../"
alias ..7="cd ../../../../../../../"
alias ..8="cd ../../../../../../../../"
alias ..9="cd ../../../../../../../../../"
alias ..10="cd ../../../../../../../../../../"

alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias ......="cd ../../../../../"
alias .......="cd ../../../../../../"
alias ........="cd ../../../../../../../"
alias .........="cd ../../../../../../../../"
alias ..........="cd ../../../../../../../../../"
alias ...........="cd ../../../../../../../../../../"

alias privat="encfs ~/Dropbox/privat/ /mnt/privat/"
alias freifunk-dropbox="encfs ~/Dropbox/ff/ /mnt/freifunk/"
alias status="git status"
alias co="git commit -a"
alias commit="co"
alias pull="git pull"
alias push="git push"
alias r="rscreen"
alias update="sudo aptitude update && sudo aptitude upgrade"
alias ssync="rsync -a -e 'ssh' --rsync-path='sudo rsync' "
alias tina="tmuxinator "
alias fritz="mplayer http://rbb.ic.llnwd.net/stream/rbb_fritz_mp3_m_a"
alias irb="pry"

# Glob aliases
alias -g G='| grep'
alias -g L='| less'
alias -g H='--help'
alias -g V='--version'

# Register special directories
hash -d doc=/usr/share/doc  # Usage: cd ~doc

# go-command to jump to directories via shortcuts
typeset -A shortcut_dirs
shortcut_dirs=(
 doc /usr/share/doc
 loc /usr/local
 init /etc/init.d
 pro ~/projects
 desk ~/Desktop
 git ~/git
 mus ~/music
 docu ~/documents
 kunden ~/Selbstständigkeit/Kunden/
 kunde ~/Selbstständigkeit/Kunden/
)

function go() {
 builtin cd ${shortcut_dirs[$1]}
}

# Dirty workaround for strange bug
if [[ $PWD == '.' ]]; then
  cd
fi

# editor
export EDITOR=vim
# pager
export PAGER="zless"
export LESS=SRMwi
# git
export GIT_AUTHOR_NAME="Daniel Meißner"
export GIT_AUTHOR_EMAIL="daniel@3st.be"

if [ `command -v kvm` ] && [ `command -v virsh` ]; then
  export VIRSH_DEFAULT_CONNECT_URI=qemu:///system
fi

# include optinal files
# rbenv
if test -d $HOME/.rbenv; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# node version manager
if test -e $HOME/.nvm/nvm.sh; then
  source $HOME/.nvm/nvm.sh
fi

# pythonbrew
if test -e $HOME/.pythonbrew/etc/bashrc; then
  [[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
fi

# rvm
if test -e $HOME/.rvm/scripts/rvm; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
fi

if test -e $HOME/.portknocking; then
  source $HOME/.portknocking
fi

