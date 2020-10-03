
CURRENT=${0}
export DARING_CLI_TOOLS_DIR=$(cd $(dirname $CURRENT)/..; pwd)

for BIN_DIR in $DARING_CLI_TOOLS_DIR/by_os/$(uname -s)/bin ${DARING_CLI_TOOLS_DIR}/bin
do
  test -d $BIN_DIR && [[ ":$PATH:" != *":$BIN_DIR:"* ]] && PATH=$BIN_DIR:$PATH
done

(cd $DARING_CLI_TOOLS_DIR && git-abcheck || echo fail)