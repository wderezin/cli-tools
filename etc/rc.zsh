
CURRENT=${0}
export DARING_CLI_TOOLS_DIR=$(cd $(dirname $CURRENT)/..; pwd)

function _shell_bin_dirs {
  for SHELL in bash zsh fish
  do
    if type $SHELL >/dev/null 2>&1
    then
      echo "$DARING_CLI_TOOLS_DIR/by_shell/${SHELL}/bin "
    fi
  done
}

for BIN_DIR in $DARING_CLI_TOOLS_DIR/by_os/$(uname -s)/bin $(_shell_bin_dirs)
do
  test -d $BIN_DIR && [[ ":$PATH:" != *":$BIN_DIR:"* ]] && PATH=$BIN_DIR:$PATH
done





(cd $DARING_CLI_TOOLS_DIR && git-abcheck || echo fail)