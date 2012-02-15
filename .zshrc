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

# End of lines added by compinstall

# History configuration
HISTFILE=~/zshhist
HISTSIZE=2000
SAVEHIST=2000

# General options
setopt autocd beep nomatch notify share_history extendedglob
unsetopt appendhistory

WORDCHARS='*?_-.[]~=&;!#$%^(){}'

# Load color variables
autoload colors zsh/terminfo

if [[ "$terminfo[colors]" -ge 8 ]]; then
 colors
fi

# Register terminal color variables for easy use
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval FG_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval FG_LIGHT_$color='%{$fg[${(L)color}]%}'
  eval BG_$color='%{$bg[${(L)color}]%}'
done

FG_NO_COLOR="%{$terminfo[sgr0]%}"

# If connected via ssh, display prompt in different color
if test -n "$SSH_CONNECTION"; then
  export PROMPT="$BG_RED${FG_LIGHT_WHITE}%n@$HOSTNAME:%~\$${FG_NO_COLOR} "
  export RPROMPT="$BG_RED${FG_LIGHT_WHITE}20%D %*${FG_NO_COLOR}"
else
  export PROMPT="${FG_LIGHT_YELLOW}%n@%m:%~\$${FG_NO_COLOR} "
  export RPROMPT='20%D %*'
fi

# Set colors for coreutils
eval "`dircolors -b`"

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
case $TERM in (xterm*)
 bindkey '\eOH' beginning-of-line
 bindkey '\eOF' end-of-line
 bindkey '\e[3~' delete-char
 bindkey '\e[2~' overwrite-mode
  bindkey '\e[3;3~' delete-word
esac

# Aliases
alias s='sudo'
alias ls='ls --color=auto'
#alias grep='grep'
alias l='ls -lh'
alias ll='ls -lah'
alias c='clear'
alias less='zless'
alias a='sudo aptitude'
alias sv='sudo service'
alias rh='rehash'
alias g='gem'
alias meld='env GTK2_RC_FILES=/usr/share/themes/Human/gtk-2.0/gtkrc meld'

alias vipw='sudo vipw'
alias vigr='sudo vigr'
alias visudo='sudo visudo'

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
alias aurisp-knock="knock gw.aurisp.de 2602:tcp 8201:tcp 4102:tcp"
alias magrathea-knock="knock gw.magrathea.3st.be 2325:tcp"
alias status="git status"
alias co="git commit -a"
alias commit="co"
alias pull="git pull"
alias push="git push"
alias r="rscreen"
alias update="sudo aptitude update && sudo aptitude upgrade"
alias irssi='SCREEN_CONF=irssi screen -S irssi -D -R irssi'
alias ssync="rsync -a -e 'ssh' --rsync-path='sudo rsync' "


# Glob aliases
alias -g G='| grep'
alias -g L='| less'
alias -g H='--help'
alias -g V='--version'

# Register special directories
#hash -d doc=/usr/share/doc  # Usage: cd ~doc

# go-command to jump to directories via shortcuts
typeset -A shortcut_dirs
shortcut_dirs=(
 doc /usr/share/doc
 loc /usr/local
 init /etc/init.d
 pro ~/projects
 gem /var/lib/gems/1.8/gems
 desk ~/Desktop
 git ~/git
)

function go() {
 builtin cd ${shortcut_dirs[$1]}
}

# Dirty workaround for strange bug
if [[ $PWD == '.' ]]; then
  cd
fi


export EDITOR=vim
export PATH=$PATH:/home/dm/CodeSourcery/Sourcery_G++_Lite/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
