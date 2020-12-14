
# Run direnv on initial fish with fish_prompt event
# Support history arrows
# To override create direnv-hook function in your ~/.config/fish/functions

function direnv-hook -a mode

    # set -q direnv_fish_mode
    # or set -g direnv_fish_mode default

    # 2 modes
    # eval_on_pwd - (default)
    # eval_after_arrow - 


    function __direnv_export_eval --on-event fish_prompt
        # Run on each prompt to update the state
        command direnv export fish | source

        if test "$direnv_fish_mode" != "disable_arrow"
            # Handle cd history arrows between now and the next prompt
            function __direnv_cd_hook --on-variable PWD
                if test "$direnv_fish_mode" = "eval_after_arrow"
                    set -g __direnv_export_again 0
                else
                    # default mode (eval_on_pwd)
                    command direnv export fish | source
                end
            end
        end
    end

    function __direnv_export_eval_2 --on-event fish_preexec
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