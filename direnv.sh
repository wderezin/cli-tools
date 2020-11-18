
nvm() {
    source $(brew --prefix nvm)/nvm.sh --no-use
    nvm $*
}

PATH_brew() {
  DIR=$(brew --prefix $1@$2)
  if [[ -d $DIR/bin ]]
  then
    PATH_add $DIR/bin
  else
    PATH_add $DIR
  fi
}

use_aws_sso() {
  AWS_REGION=${AWS_REGION-us-east-1}

  if [ ! -z ${AWS_PROFILE+x} ]
  then
      eval "$(aws2-wrap --profile ${AWS_PROFILE} --export)"
  fi

  watch_file  ~/.aws/sso/cache/*.json
}