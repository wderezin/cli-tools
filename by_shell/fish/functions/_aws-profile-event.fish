
# Set a color for the current AWS access
# which is used in the fish_prompt

function _aws-profile-event --on-variable="AWS_PROFILE" --on-variable="AWS_SESSION_TOKEN" --on-variable "AWS_ACCESS_KEY_ID"
  set -l red (set_color red)
  set -l green (set_color green)
  set -l normal (set_color normal)

  if set -q AWS_PROFILE
    if aws sts get-caller-identity >/dev/null 2>&1
      set -g aws_access_color $green
    else
      set -g aws_access_color $red
    end
  else
    set -g aws_access_color $normal
  end

end