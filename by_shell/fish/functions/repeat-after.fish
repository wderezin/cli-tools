
function repeat-after --description "Wait until after seconds have passed<CHECK VARIABLE> <SECONDS>"
    set check_var $argv[1]
    set wait_seconds $argv[2]

    # Use $ here, because we are checking that the reference variable exists, not checking if CHECK_VAR exits
    if ! set -q $check_var
        set -g $check_var (date +%s)
        return 0
    else if test (date +%s) -gt (math $$check_var + $wait_seconds)
        set -g $check_var (date +%s)
        return 0
    else
        return 1
    end

end