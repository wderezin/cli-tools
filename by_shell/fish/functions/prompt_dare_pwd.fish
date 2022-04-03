
# No Longer Used, using fish prompt_pwd
function prompt_dare_pwd --description "Print the current working directory, shortened to fit the prompt"

    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)

    set -l options h/help
    argparse -n prompt_pwd --max-args=0 $options -- $argv
    or return

    if set -q _flag_help
        __fish_print_help prompt_pwd
        return 0
    end


    # This allows overriding fish_prompt_pwd_dir_length from the outside (global or universal) without leaking it
    set -q fish_prompt_pwd_dir_length
    or set -l fish_prompt_pwd_dir_length 0

    # Replace $HOME with "~"
    set realhome ~
    set -l tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)

    if test $fish_prompt_pwd_dir_length -eq 0
        echo -n $blue$tmp$normal
    else
        # Shorten to at most $fish_prompt_pwd_dir_length characters per directory
        echo -n $blue(string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' $tmp)$normal
    end

end
