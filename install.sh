#!/bin/sh

if [ `dirname $0` = "." ]; then
  DIR_NAME=""
else
  DIR_NAME=`dirname $0i`
fi

PWD=`pwd`
SCRIPT_DIR="${PWD}/${DIR_NAME}"

# if dotfiles not exits, link them to repositorie
for FILE in `ls -1a \
                -I $0 \
                -I bin \
                -I README.md \
                -I . -I .. \
                -I .git -I .gitignore \
                -I install.rb -I install.sh \
                $SCRIPT_DIR`; do

  if [ ! -e $HOME/$FILE ]; then
    ln -s $SCRIPT/$FILE $HOME/$FILE
  fi

  echo `ls -lgo $HOME/$FILE`
done

# create ~/.zsh directory if not exist
for DIRECTORY in "${HOME}/.zsh"; do
  if [ ! -e $DIRECTORY ]; then
    mkdir $DIRECTORY
    echo $DIRECTORY created
  fi
done

# create empty file ~/.portknocking if not exist
for FILE in "$HOME/.portknocking"; do
  if [ ! -e $FILE ]; then
    touch $FILE
    echo $FILE created
  fi
done

exit 0
