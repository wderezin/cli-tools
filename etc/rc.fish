
set DARING_CLI_TOOLS_DIR (dirname (dirname (realpath (status -f))))

set --path fish_function_path $DARING_CLI_TOOLS_DIR/fish/functions $fish_function_path

set DARING_CLI_BIN $DARING_CLI_TOOLS_DIR/bin
contains DARING_CLI_BIN $fish_user_paths; or set -Ua fish_user_paths DARING_CLI_BIN
