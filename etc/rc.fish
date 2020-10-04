
set DARING_CLI_TOOLS_DIR (dirname (dirname (realpath (status -f))))

for FUNCTION_DIR in $DARING_CLI_TOOLS_DIR/by_shell/fish/functions
  test -d $FUNCTION_DIR; and ! contains $FUNCTION_DIR $fish_function_path; and set -p fish_function_path $FUNCTION_DIR
end

for BIN_DIR in $DARING_CLI_TOOLS_DIR/by_os/(uname -s)/bin (_shell_bin_dirs)
  test -d $BIN_DIR; and ! contains $BIN_DIR $PATH; and set -p PATH $BIN_DIR; and echo set
end

set -l DAY_IN_SECONDS 86400
if ! set -q DCT_LAST_CHECK ||  test (date +%s) -gt (math $DCT_LAST_CHECK + $DAY_IN_SECONDS)
  set -U DCT_LAST_CHECK (date +%s)
  echo checking
  withd $DARING_CLI_TOOLS_DIR git-abcheck
end
