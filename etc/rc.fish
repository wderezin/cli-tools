
set DARING_CLI_TOOLS_DIR (dirname (dirname (realpath (status -f))))

set DARING_FUNCTIONS_DIR $DARING_CLI_TOOLS_DIR/fish/functions
contains $DARING_FUNCTIONS_DIR $fish_function_path or set --path fish_function_path $DARING_FUNCTIONS_DIR $fish_function_path

set DARING_CLI_BIN $DARING_CLI_TOOLS_DIR/bin
contains $DARING_CLI_BIN $fish_user_paths; or set -Ua fish_user_paths DARING_CLI_BIN
