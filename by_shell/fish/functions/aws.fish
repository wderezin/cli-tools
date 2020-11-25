
function aws --wraps aws --description 'triggers '
    if command aws $argv
        if test $argv[1] = "sso"; and test $argv[2] = "login"; and command -q direnv
            direnv reload
        end
        return 0
    end
    return $status
end
