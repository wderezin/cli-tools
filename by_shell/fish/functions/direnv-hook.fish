
# Run direnv on initial fish with fish_prompt event
# Support history arrows
# To override create direnv-hook function in your ~/.config/fish/functions

function direnv-hook

    set -q direnv_eval_on_pwd
    or set -g direnv_eval_on_pwd true

    function __direnv_export_eval --on-event fish_prompt
        # Run on each prompt to update the state
        command direnv export fish | source

        # Handle cd history arrows between now and the next prompt
        function __direnv_cd_hook --on-variable PWD
            test $direnv_eval_on_pwd
            and command direnv export fish | source
            or set -g __direnv_export_again 0
        end
    end

    function __direnv_disable_cd_hook --on-event fish_preexec
        if set -q __direnv_export_again
            set -e __direnv_export_again
            command direnv export fish | source
            echo
        end

        # Once we're running commands, stop monitoring cd changes
        # until we get to the prompt again
        functions --erase __direnv_cd_hook
    end
end