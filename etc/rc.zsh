
CURRENT=${0}
export DARING_CLI_TOOLS_DIR=$(cd $(dirname $CURRENT)/..; pwd)

[[ ":$PATH:" != *":$DARING_CLI_TOOLS_DIR/bin:"* ]] && PATH=$DARING_CLI_TOOLS_DIR/bin:$PATH

if [[ $- == *i* ]]
then
  # Interactive mode
  (cd $DARING_CLI_TOOLS_DIR && git-abcheck)
fi

eval "$(direnv hook zsh)"