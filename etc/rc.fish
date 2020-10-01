
set CLI_BIN (dirname (dirname (realpath (status -f))))/bin
contains $CLI_BIN $fish_user_paths; or set -Ua fish_user_paths $CLI_BIN
