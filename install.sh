#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
for file in $(ls -1a | grep "^\.[a-z][a-z\._-]\+$" ); do
  if [ "$file" == ".git" ]; then
    continue
  fi
  if [ -f "$HOME/$file" ] || [ -h "$HOME/$file" ] || [ -d "$HOME/$file" ]
  then
    echo -n "$HOME/$file already exists. do you want to overwrite? this will remove the existing file or folder. (y/n): "
    read response
    if [ "$response" == "y" ]
    then
      rm -rf $HOME/$file
      echo "Removing $HOME/$file.."
      echo "Installing $HOME/$file"
      ln -s $DIR/$file $HOME/$file
    fi
  else
    echo "Installing $HOME/$file"
    ln -s $DIR/$file $HOME/$file
  fi
done

echo -n "Want to install all vim plugins using PlugInstall? (y/n): "
read response
if [ "$response" == "y" ]
then
  git submodule init
  git submodule update
  vi -c 'PlugInstall|qa'
fi
