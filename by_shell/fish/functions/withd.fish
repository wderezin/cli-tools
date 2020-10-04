
function withd --description "Change to directory and run the command <DIRECTORY> <COMMMAND>"
  pushd $argv[1]; or return 2
  set -e argv[1]

  eval $argv
  set -l return_status $last_status

  popd
  return $return_status
end