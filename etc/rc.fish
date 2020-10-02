
set DARING_CLI_TOOLS_DIR (dirname (dirname (realpath (status -f))))

set DARING_FUNCTIONS_DIR $DARING_CLI_TOOLS_DIR/fish/functions
contains $DARING_FUNCTIONS_DIR $fish_function_path; or set -p fish_function_path $DARING_FUNCTIONS_DIR

set DARING_CLI_BIN $DARING_CLI_TOOLS_DIR/bin
contains $DARING_CLI_BIN $fish_user_paths; or set -p fish_user_paths $DARING_CLI_BIN

set OS_NAME (uname -s)
set OS_BIN $DARING_CLI_TOOLS_DIR/$OS_NAME/bin

test -d $OS_BIN; and contains $OS_BIN $fish_user_paths; or set -p fish_user_paths $OS_BIN

pushd $DARING_CLI_TOOLS_DIR
git-ud
popd