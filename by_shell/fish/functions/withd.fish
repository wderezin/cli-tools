
function withd --description "Change to directory and run the command"
  if test -z $_WITHD_NEST
    pushd $argv[1]; or return 2
    set -e argv[1]
    set -x _WITHD_NEST 1

    fish -c "$argv"
    set -l return_status $last_status

    popd
    set -e _WITHD_NEST
    return $return_status
  end
end