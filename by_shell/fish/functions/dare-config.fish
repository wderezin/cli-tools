
function __dare_config_show
  if [ "$format" = "details" ]
    echo $argv[1]
    echo "    Description: " $argv[2]
    echo "         Values: " $argv[3]
    echo "        Default: " $argv[4]
    echo "        Current: " (eval echo $$argv[1])
  else
    echo $argv[1]':' (set -q $argv[1]; and eval echo $$argv[1]; or eval echo $argv[4])
  end
end

function dare-config --description 'Display current setting for Dare cli-tools'

  if [ "$argv[1]" = "--details" ]
    set -x format "details"
  end

  if test "$format" = "details"
    echo 'Variables:'
  end

  __dare_config_show 'dare_prompt_git_path' \
                     'In git prompt, PWD is relative to the git root directory' \
                     'true|false' \
                     'true'

  __dare_config_show 'dare_prompt_git_ahead_behind_count' \
                     'In git prompt, show the count ahead and behind' \
                     'true|false' \
                     'true'

  __dare_config_show 'dare_prompt_git_remote' \
                     'In git prompt, the remote name to compare with' \
                     'string' \
                     'origin'
      
  __dare_config_show 'fish_prompt_pwd_dir_length' \
                     'How many characters to include when shorting the path' \
                     '0 - disabled, 1+ - enabled' \
                     '1'

end
