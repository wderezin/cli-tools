
# Used in combination with direnv reload_on_pwd
function _pwd-change-prompt-event --on-event fish_prompt
    if test "$PREVIOUS_PWD" != "$PWD"
        set -g -x PREVIOUS_PWD $PWD
        emit pwd_change_prompt
    end
end