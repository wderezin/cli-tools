
function daily-check --description "Only run the command once per 24 hours <CHECK VARIABLE> <COMMAND>"
    set -l DAY_IN_SECONDS 86400
    set CHECK_VAR $argv[1]
    set -e argv[1]
    if ! set -q $CHECK_VAR || test (date +%s) -gt (math $$CHECK_VAR + $DAY_IN_SECONDS)
        set -U $CHECK_VAR (date +%s)
        eval $argv
    end
end