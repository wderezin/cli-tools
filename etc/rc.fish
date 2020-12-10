
set -g dare_cli_tools_dir (dirname (dirname (realpath (status -f))))

# Add function path
set -l function_dir $dare_cli_tools_dir/by_shell/fish/functions
test -d $function_dir; and ! contains $function_dir $fish_function_path; and set -p fish_function_path $function_dir

# Add bin to PATH
set -l bin_dir $dare_cli_tools_dir/bin
contains $bin_dir PATH; or set -p PATH $bin_dir

if contains ~/.config/fish/functions $fish_function_path
    if test (contains -i ~/.config/fish/functions $fish_function_path) -gt 1
        set -e fish_function_path[(contains -i ~/.config/fish/functions $fish_function_path)]
        set -p fish_function_path ~/.config/fish/functions
    end
else
    set -p fish_function_path ~/.config/fish/functions
end

if status --is-interactive

    #  direnv hook fish | source 
    if command -q direnv
        direnv-hook
    end

    # Setup aws auto complete
    if command -q aws_completer
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
    end

    # Make sure all event functions are loaded
    for func in (functions -a | grep '-event$')
        functions -D $func >/dev/null
    end

    daily-check __dare_last_update_check "withd $dare_cli_tools_dir git-abcheck"

end
