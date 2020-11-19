#!/usr/bin/env bash

function error {
	echo $*
	exit 2
}

CURRENT=${0}
export DARING_CLI_TOOLS_DIR=$(cd $(dirname $CURRENT); pwd)

if type fish >/dev/null 2>&1
then
  if ! test -e ~/.config/fish/conf.d/cli-tools.fish
  then
    if ! test -d ~/.config/fish/conf.d
    then
      mkdir -p ~/.config/fish/conf.d
    fi
    ln -s $DARING_CLI_TOOLS_DIR/etc/rc.fish ~/.config/fish/conf.d/cli-tools.fish
    echo Linked ~/.config/fish/conf.d/cli-tools.fish
  fi
fi

function add_line {
  RCFILE=$1
  LINE=$2
  if ! test -e $RCFILE
  then
    touch $RCFILE
  fi
  if ! grep daringway-cli-tools $RCFILE >/dev/null 2>&1
  then
    echo $LINE "# daringway-cli-tools" >> $RCFILE
    echo updated $RCFILE
  fi
}

if type bash >/dev/null 2>&1
then
  RCFILE=~/.bashrc
  LINE="eval \"\$(${DARING_CLI_TOOLS_DIR}/etc/bash-init)\""
  if ! test -e $RCFILE
  then
    touch $RCFILE
  fi
  if ! grep daringway-cli-tools $RCFILE >/dev/null 2>&1
  then
    echo $LINE "# daringway-cli-tools" >> $RCFILE
    echo updated $RCFILE
  fi
fi

if type zsh >/dev/null 2>&1
then
  RCFILE=~/.zshenv
  LINE="source \"${DARING_CLI_TOOLS_DIR}/etc/rc.zsh\""
  if ! test -e $RCFILE
  then
    touch $RCFILE
  fi
  if ! grep daringway-cli-tools $RCFILE >/dev/null 2>&1
  then
    echo $LINE "# daringway-cli-tools" >> $RCFILE
    echo updated $RCFILE
  fi
fi

DIRENV_DIR=~/.config/direnv/lib
if ! test -f $DIRENV_DIR/cli-tools.sh
then
  mkdir -p $DIRENV_DIR 2>/dev/null
  ln -s $DARING_CLI_TOOLS_DIR/direnv.sh $DIRENV_DIR/cli-tools.sh
fi

for P in dir env fish python3 sh jq git ssh mssh bash
do
  if ! type $P >/dev/null 2>&1
  then
    echo "WARNING:\"${P}\" not installed, install for full functionality"
  fi
done
