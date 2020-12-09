
nvm() {
    source $(brew --prefix nvm)/nvm.sh --no-use
    nvm $*
}

PATH_brew() {
  if test -n $2
  then
    DIR=$(brew --prefix $1@$2)
  else
    DIR=$(brew --prefix $1)
  fi

  if [[ -d $DIR/bin ]]
  then
    PATH_add $DIR/bin
  else
    PATH_add $DIR
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
      # if [ "${AWS_SESSION_TOKEN}" != "" ]
      # then
      #   # Used by fish shell _aws-credential-event prompt_account functions
      #   export AWS_AUTH_ON="$(date)"
      # else
      #   export AWS_AUTH_ON=""
      # fi
  fi

  watch_file  ~/.aws/sso/cache/*.json
}

use_aws_credentials() {
  AWS_REGION=${AWS_REGION-us-east-1}

  if test -n "$1"
  then
    export AWS_PROFILE=$1
  fi 

  if [ -n "${AWS_PROFILE}" ]
  then
      if command aws sts get-caller-identity >/dev/null 2>&1
      then
        # Used by fish shell _aws-credential-event and prompt_account functions
        export AWS_AUTH_ON="$(date)"
      else
        export AWS_AUTH_ON=""
      fi
  fi


  watch_file ~/.aws/credentials
}
