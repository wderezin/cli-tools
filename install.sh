#!/usr/bin/env sh

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
  if ! grep cli-tools $RCFILE >/dev/null 2>&1
  then
    echo $LINE >> $RCFILE
    echo updated $RCFILE
  fi
}

if type bash >/dev/null 2>&1
then
  add_line ~/.bashrc "source \$(${DARING_CLI_TOOLS_DIR}/etc/bash-init)"
fi

if type zsh >/dev/null 2>&1
then
  add_line ~/.zshenv "source ${DARING_CLI_TOOLS_DIR}/etc/rc.zsh"
fi

