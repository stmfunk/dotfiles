#!/bin/sh

if [ `dirname $0` = "." ]; then
  DIR_NAME=""
else
  DIR_NAME=`dirname $0i`
fi

PWD=`pwd`
SCRIPT_DIR="${PWD}/${DIR_NAME}"

DOTFILES=`ls -1a \
              -I $0 \
              -I bin \
              -I README.md \
              -I . -I .. \
              -I .git -I .gitignore \
              -I install.rb -I install.sh \
              $SCRIPT_DIR`

link_files() {
  # if dotfiles not exists, link them to repositorie
  for FILE in $DOTFILES; do
    if [ ! -e $HOME/$FILE ]; then
      ln -s $SCRIPT/$FILE $HOME/$FILE
    fi

    echo `ls -lgo $HOME/$FILE`
  done
}

create_directories() {
  # create required directories if not exist
  for DIRECTORY in "${HOME}/.zsh"; do
    if [ ! -e $DIRECTORY ]; then
      mkdir $DIRECTORY
      echo $DIRECTORY created
    fi
  done
}

create_files() {
  # create empty files
  for FILE in "$HOME/.portknocking"; do
    if [ ! -e $FILE ]; then
      touch $FILE
      echo $FILE created
    fi
  done
}

# remove dotfiles
remove_files() {
  echo "Nothing removed."
}

remove_directories() {
  echo "Nothing removed."
}

case $1 in
  install )
    link_files
    create_files
    create_directories
    ;;

  remove|uninstall )
    remove_files
    remove_directories
    ;;
  * )
    echo "Usage: ${PWD}/${0} <install|remove>"
    exit 1
    ;;
esac

exit 0
