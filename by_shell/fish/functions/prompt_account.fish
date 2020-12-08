

function prompt_account
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  # Display [venvname] if in a virtualenv
  if set -q VIRTUAL_ENV
    set -a acc_info $aws_access_color'VENV:'(string lower(basename $VIRTUAL_ENV))$normal
  end

  set -q aws_access_color
  or set aws_access_color $yellow

  if set -q AWS_AUTH_ON
    if test -z "$AWS_AUTH_ON"
      set -g aws_access_color $fish_color_error
    else
      set -g aws_access_color (set_color green)
    end
  end
  if set -q AWS_PROFILE
    set -a acc_info $aws_access_color'AWS:'(string lower $AWS_PROFILE)$normal
  else if set -q AWS_ACCESS_KEY_ID
    set -a acc_info $aws_access_color'AWS:'(string lower (string sub --start=-4 $AWS_ACCESS_KEY_ID))$normal
  end

  if set -q IBM_PROFILE
    set -a acc_info $yellow'IBM:'$IBM_PROFILE$normal
  else if set -q IBMCLOUD_API_KEY
    set -a acc_info $yellow'IBM:'(string lower (string sub --start=-4 $IBMCLOUD_API_KEY))$normal
  end

  if set -q ETCDV3_USERNAME
   set -a acc_info $yellow'ETC:'(string lower (string sub --start=-4 $ETCDV3_USERNAME))$normal
  end

  if set -q acc_info
    echo -n -s '[' (string join , $acc_info) ']'
    return 0
  end

  return 1

end
