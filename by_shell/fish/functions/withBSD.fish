
function withBSD --description "Only eval <COMMAND> if on a BSD system, including Mac OS X"

    if not contains (uname -s) Darwin BSD bsd
        return 1
    end

    eval $argv
    return $last_status
end