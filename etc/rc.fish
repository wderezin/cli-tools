
set DARING_CLI_TOOLS_DIR (dirname (dirname (realpath (status -f))))

for FUNCTION_DIR in $DARING_CLI_TOOLS_DIR/by_shell/fish/functions
  test -d $FUNCTION_DIR; and contains $FUNCTION_DIR $fish_function_path; or set -p fish_function_path $FUNCTION_DIR
end

for BIN_DIR in $DARING_CLI_TOOLS_DIR/by_os/(uname -s)/bin $DARING_CLI_TOOLS_DIR/bin
  test -d $BIN_DIR; and contains $BIN_DIR $PATH; or set -p PATH $BIN_DIR
end

withd $DARING_CLI_TOOLS_DIR git-abcheck
