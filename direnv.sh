
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
