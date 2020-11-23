
function abc
  if [ "$format" = "details" ]
    echo $argv[1]
    echo "    Description: " $argv[2]
    echo "         Values: " $argv[3]
    echo "        Default: " $argv[4]
    echo "        Current: "(eval echo $argv[1])
  else
    echo $argv[1]':' (eval echo $$argv[1])
  end
end

function dare-config --description 'Display current setting for Dare cli-tools'

  if [ "$argv[1]" = "--details" ]
    set -x format "details"
  end

  if test "$format" = "details"
    echo 'Variables:'
  end

  abc 'dare_prompt_git_path' \
      'In prompt, PWD is relative to the git root directory' \
      'true|false' \
      'true'

  abc 'fish_prompt_pwd_dir_length' \
                'How many characters to include when shorting the path' \
                '0 - disabled, 1+ - enabled' \
                '1'

end
