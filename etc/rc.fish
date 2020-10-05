set -g DARING_CLI_TOOLS_DIR (dirname (dirname (realpath (status -f))))

for FUNCTION_DIR in $DARING_CLI_TOOLS_DIR/by_shell/fish/functions
  test -d $FUNCTION_DIR; and ! contains $FUNCTION_DIR $fish_function_path; and set -p fish_function_path $FUNCTION_DIR
end

# Add bin directories to PATH
DIR=$DARING_CLI_TOOLS_DIR/by_os/(uname -s)/bin test -d $BIN_DIR; and ! contains $DIR $PATH; and set -p PATH $DIR
for SHELL in (withd $DARING_CLI_TOOLS_DIR/by_shell command ls)
  set DIR $DARING_CLI_TOOLS_DIR/by_shell/$SHELL/bin
  if type $SHELL >/dev/null 2>&1; and test -d $DIR; and ! contains $DIR $PATH
    set -p PATH $DIR
  end
end

if status --is-interactive
  daily-check DCT_LAST_CHECK "withd $DARING_CLI_TOOLS_DIR git-abcheck"
end
