
# Load functions
for FILE in $DARING_CLI_TOOLS_DIR/by_shell/bash/functions/*.bash
do
  source $FILE
done

[[ ":$PATH:" != *":$DARING_CLI_TOOLS_DIR/bin:"* ]] && PATH=$PATH:$DARING_CLI_TOOLS_DIR/bin:

if shopt -q interactive_comments
then
  # interactive mode
  (cd $DARING_CLI_TOOLS_DIR && git-abcheck)
fi

eval "$(direnv hook bash)"