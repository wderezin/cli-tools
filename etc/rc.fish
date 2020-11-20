set -g DARING_CLI_TOOLS_DIR (dirname (dirname (realpath (status -f))))

# Add function path
set -l FUNCTION_DIR $DARING_CLI_TOOLS_DIR/by_shell/fish/functions
test -d $FUNCTION_DIR; and ! contains $FUNCTION_DIR $fish_function_path; and set -p fish_function_path $FUNCTION_DIR

# Make sure all event functions are loaded
for func in (functions -a | grep '-event$')
  functions -D $func > /dev/null
end

# Add bin bin to PATH
set -l BIN_DIR $DARING_CLI_TOOLS_DIR/bin
! contains $BIN_DIR  PATH; and set -p PATH $BIN_DIR

if status --is-interactive
  daily-check DCT_LAST_CHECK "withd $DARING_CLI_TOOLS_DIR git-abcheck"
end

eval (direnv hook fish)

