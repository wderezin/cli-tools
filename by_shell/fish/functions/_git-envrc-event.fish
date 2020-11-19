
# If a .envrc does not exist
# and you are in a git repo
# and if a any .*-envrc exist
# then create a .envrc to source the .*-envrc

# ~/.config/fish/functions/create-envrc
function _git-envrc-event --on-variable="PWD"
  set -l red (set_color red)
  set -l normal (set_color normal)

  if git rev-parse --git-dir >/dev/null 2>/dev/null
    set -l files .*-envrc
    if count $files > 0

      for file in $files
        if ! egrep -w "source_env\s+$file" .envrc >/dev/null 2>&1
          echo -s $red "Error direnv: missing $file, add \"source_env $file\" to .envrc" $normal ' '
        end
      end
      if ! test -f .envrc
        echo -n -s $red 'Error direnv: or run `create-envrc` to create .envrc' $normal ' '
        return
      end
    end
  end

end