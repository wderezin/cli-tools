
nvm() {
    source $(brew --prefix nvm)/nvm.sh --no-use
    nvm $*
}

# Used in combination with shell.
# Shell needs to check that DIRENV_RELOAD_ON_PWD is set when  PWD is changed
# And when changed run direnv reload
# Also, shell needs to set CURRENT_PWD to the current PWD so the sub directory can access the PWD.
reload_on_pwd() {
    export DIRENV_RELOAD_ON_PWD=1
}

source_ext() {
    for X in $*
    do
        source_env .envrc-$X
    done 
}

source_ext_if_exists() {
    for X in $*
    do
        source_env_if_exists .envrc-$X
    done 
}

source_local() {
    source_env ~/.config/direnv/local/$1
}

source_local_if_exists() {
    source_env_if_exists ~/.config/direnv/local/$1
}

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
    if ! which tfswitch >/dev/null 2>&1
    then
        echo "ERROR: Install tfswitch for use_terraform support"
        return 1
    fi

    if ! test -d .terraform
    then
        mkdir .terraform 2>/dev/null
    fi

    if test -n $1
    then
        INSTALL_VERSION=${1#v}
        if [[ "${INSTALL_VERSION}" =~ [0-9]+.[0-9]+.[0-9]+ ]]
        then
            tfswitch -b .terraform/terraform ${INSTALL_VERSION}
        else
            tfswitch -b .terraform/terraform --latest-stable ${INSTALL_VERSION}        
        fi
    else
        tfswitch -b .terraform/terraform --latest
    fi

    PATH_add .terraform
}

use_aws_sso() {
  AWS_REGION=${AWS_REGION-us-east-1}

  if test -n "$1"
  then
    export AWS_PROFILE=$1
  fi 

  CACHE_DIR=~/.config/direnv/use_aws_sso_cache
  CACHE_FILE=${CACHE_DIR}/${AWS_PROFILE}

  if [ -n "${AWS_PROFILE}" ]
  then
    if ! test -e "$CACHE_FILE"
    then
        echo "Caching AWS credentials $CACHE_FILE"
        test -d $CACHE_DIR || mkdir -p $CACHE_DIR
        aws2-wrap --profile ${AWS_PROFILE}  --process > $CACHE_FILE
    fi

    eval $(cat $CACHE_FILE | jq -r 'to_entries|map("\(.key)=\"\(.value|tostring)\"")|.[]')
    # if current date > expiriation date
    # echo check exp $Expiration
    if [[ "$Expiration" == "" ]] 
    then
        ExpEpoch=0
    else
        ExpEpoch=$(date -j -f "%Y-%m-%d %H:%M:%S%z" "$(echo $Expiration | perl -pe 's/:(\d\d)$/\1/; s/T/ /')" +%s)
    fi
    if (( $(date +%s) > $ExpEpoch ))
    then
        echo "Caching AWS credentials $CACHE_FILE"
        aws2-wrap --profile ${AWS_PROFILE}  --process > $CACHE_FILE
        eval $(cat $CACHE_FILE | jq -r $JQ_EXTRACT)
    fi

    export AWS_ACCESS_KEY_ID=$AccessKeyId
    export AWS_SECRET_ACCESS_KEY=$SecretAccessKey
    export AWS_SESSION_TOKEN=$SessionToken
    export AWS_EXPIRATION=$Expiration
    export AWS_REGION=${AWS_REGION-us-esat-1}

    watch_file $CACHE_FILE
  fi
}

use_aws_credentials() {
  AWS_REGION=${AWS_REGION-us-east-1}

  if test -n "$1"
  then
    export AWS_PROFILE=$1
  fi 

  SOURCE_PROFILE="$(sed -nr '1,/\['${AWS_PROFILE}'\]/d;/\[/,$d;/^$/d;/^source_profile/ s/.*\= *// p' ~/.aws/credentials 2>/dev/null)"
  if [ "$SOURCE_PROFILE" = "" ]
  then
    SOURCE_PROFILE=$AWS_PROFILE
  fi

  AWS_EXPIRATION="$(sed -nr '1,/\['${SOURCE_PROFILE}'\]/d;/\[/,$d;/^$/d;/^expiration/ s/.*\= *// p' ~/.aws/credentials 2>/dev/null)"
  if [ "$AWS_EXPIRATION" != "" ]
  then
    export AWS_EXPIRATION
  else
    export AWS_CREDS_CHANGED="$(date)"
  fi

  export AWS_REGION=${AWS_REGION-us-esat-1}
  export AWS_SDK_LOAD_CONFIG=${AWS_SDK_LOAD_CONFIG-yes}

  watch_file ~/.aws/credentials
}
