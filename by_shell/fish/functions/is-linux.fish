
function is-linux --description "Only eval <COMMAND> if on a Linux based system"

    if not contains (uname -s) Linux
        return 1
    end

    eval $argv
    return $last_status
end