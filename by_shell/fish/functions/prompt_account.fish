
function _setPreviousAWS
    set -g previous_AWS_PROFILE $AWS_PROFILE
    set -g previous_AWS_SESSION_TOKEN $AWS_SESSION_TOKEN
    set -g previous_AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY_ID
    set -g previous_AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY
    set -g previous_AWS_CREDS_CHANGED $AWS_CREDS_CHANGED
    set -g previous_AWS_EXPIRATION $AWS_EXPIRATION
end

function _awsChanged
    test "$previous_AWS_PROFILE" = "$AWS_PROFILE"
    and test "$previous_AWS_SESSION_TOKEN" = "$AWS_SESSION_TOKEN"
    and test "$previous_AWS_ACCESS_KEY_ID" = "$AWS_ACCESS_KEY_ID"
    and test "$previous_AWS_SECRET_ACCESS_KEY" = "$AWS_SECRET_ACCESS_KEY"
    and test "$previous_AWS_CREDS_CHANGED" = "$AWS_CREDS_CHANGED"
    and test "$previous_AWS_EXPIRATION" = "$AWS_EXPIRATION"
    and return 1

    return 0
end

function prompt_account
    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)

    # Display [venvname] if in a virtualenv
    if set -q VIRTUAL_ENV
        set -a acc_info $prompt_aws_access_color'VENV:'(string lower(basename $VIRTUAL_ENV))$normal
    end

    if _awsChanged
        if test -n $AWS_PROFILE; or test -n $AWS_ACCESS_KEY_ID
            if command aws sts get-caller-identity >/dev/null 2>&1
                set -g prompt_aws_access_color (set_color green)
            else
                set -g prompt_aws_access_color (set_color red)
            end
        end
        set -g prompt_aws_prefix 'AWS'
        _setPreviousAWS
    end

    if set -q AWS_EXPIRATION; and test (date +%s) -gt (date -j -f "%Y-%m-%dT%H:%M:%S%z" $AWS_EXPIRATION +%s 2>/dev/null)
        set -g prompt_aws_access_color $red
        set prompt_aws_prefix '(expired)AWS'
    end

    if set -q AWS_PROFILE
        set -a acc_info $prompt_aws_access_color$prompt_aws_prefix':'(string lower $AWS_PROFILE)$normal
    else if set -q AWS_ACCESS_KEY_ID
        set -a acc_info $prompt_aws_access_color$prompt_aws_prefix':'(string lower (string sub --start=-4 $AWS_ACCESS_KEY_ID))$normal
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
