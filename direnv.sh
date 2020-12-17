
nvm() {
    source $(brew --prefix nvm)/nvm.sh --no-use
    nvm $*
}

#alias_dir=$PWD/.direnv/aliases
#rm -rf "$alias_dir"
#export_alias() {
#  local name=$1
#  shift
#  local alias_dir=$PWD/.direnv/aliases
#  local target="$alias_dir/$name"
#  mkdir -p "$alias_dir"
#  PATH_add "$alias_dir"
#  echo "#!/usr/bin/env bash -e" > "$target"
#  echo "$@" >> "$target"
#  chmod +x "$target"
#}

export_alias() {
  local name=$1
  shift
  if [ "$DIRENV_ALIASES" = "" ]
  then
    export DIRENV_ALIASES="${name} \"$@\""
  else
    DIRENV_ALIASES="$DIRENV_ALIASES:alias:${name} \"$@\""
  fi
}

PATH_brew() {
  if test -n $2
  then
    FIND="$1@$2"
  else
    FIND="$1"
  fi

  DIR=$(brew --prefix $FIND)

  if [[ -d $DIR/bin ]]
  then
    PATH_add $DIR/bin
  else
    PATH_add $DIR
  fi
}

use_terraform() {
  if test -n $2
  then
    FIND="$1@$2"
  else
    FIND="$1"
  fi
  DIR=$(brew --prefix $FIND)
  if [[ -x $DIR/bin/terraform ]]
  then
    export alias terraform $DIR/bin/terraform
  else
    echo "direnv: ERROR can not find $FIND"
  fi
}

use_aws_sso() {
  AWS_REGION=${AWS_REGION-us-east-1}

  if test -n "$1"
  then
    export AWS_PROFILE=$1
  fi 

  if [ -n "${AWS_PROFILE}" ]
  then
      eval "$(aws2-wrap --profile ${AWS_PROFILE} --export)"
  fi

  watch_file  ~/.aws/sso/cache/*.json
}

use_aws_credentials() {
  AWS_REGION=${AWS_REGION-us-east-1}

  if test -n "$1"
  then
    export AWS_PROFILE=$1
  fi 

  export AWS_CREDS_CHANGED="$(date)"

  watch_file ~/.aws/credentials
}
