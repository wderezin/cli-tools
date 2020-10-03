
function withd
  if test -z $_WITHD_NEST
    pushd $argv[1]; or return 2
    set -x _WITHD_NEST 1
    fish -c $argv[2]
    set -l return_status $last_status
    popd
    set -e _WITHD_NEST
    return $return_status
  end
end