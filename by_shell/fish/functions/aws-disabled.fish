
function aws-disabled --wraps aws --description 'triggers direnv reload on aws sso login'
    if command aws $argv
        if test $argv[1] = "sso"; and test $argv[2] = "login"; and command -q direnv; and direnv status | grep 'Found RC allowed true' >/dev/null
            command direnv reload
        end
        return 0
    end
    return $status
end
