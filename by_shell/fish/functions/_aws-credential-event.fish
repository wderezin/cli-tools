
# Set a color for the current AWS access
# which is used in the fish_prompt

function _aws-credential-event --on-variable="AWS_PROFILE" --on-variable="AWS_SESSION_TOKEN" --on-variable "AWS_ACCESS_KEY_ID"
  if repeat-after __aws_cred_check_repeat 1
    # AWS_AUTH_ON is set by direnv use_aws_sso
    if ! set -q AWS_AUTH_ON
      if set -q AWS_PROFILE; or set -q AWS_SESSION_TOKEN
        if command aws sts get-caller-identity >/dev/null 2>&1
          set -g aws_access_color (set_color green)
        else
          set -g aws_access_color (set_color yellow)
        end
      else
        set -g aws_access_color (set_color normal)
      end
    end
  end
end