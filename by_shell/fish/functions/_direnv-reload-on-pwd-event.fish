
# Used in combination with direnv reload_on_pwd
function _direnv-reload-on-pwd-event --on-event fish_prompt
    if test "$PREVIOUS_PWD" != "$PWD"
        if is-enabled $DIRENV_RELOAD_ON_PWD; and direnv status | grep 'Found RC allowed true' >/dev/null
            set -g -x PREVIOUS_PWD $PWD
            direnv reload
        end
    end
end
