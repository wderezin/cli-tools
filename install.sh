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

function printWarning {
  if [[ "${WARNING_PRINTED}" == "" ]]
  then
    WARNING_PRINTED=yes
    echo "WARNING: not all applications and packages are installed for full cli-tools functionality"
    echo "         install missing appllications and packages and run install.sh again"
  fi
  echo "   "$*
}

# Check if all the required applications are installed.
for P in direnv env fish python3 pip3 sh jq git ssh bash aws_completer
do
  if ! type $P >/dev/null 2>&1
  then
    printWarning  ""\"${P}\" not installed""
  fi
done

# Check for python libraries
if type pip3 >/dev/null 2>&1
then
  for P in boto3 aws2-wrap ec2instanceconnectcli
  do
    if ! pip3 show $P >/dev/null 2>&1
    then
      printWarning "\"$P\" not installed, to install:  \"pip3 install ${P}\""
    fi
  done
fi