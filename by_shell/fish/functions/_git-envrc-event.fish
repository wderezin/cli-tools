
# If a .envrc does not exist
# and you are in a git repo
# and if a any .*-envrc exist
# then create a .envrc to source the .*-envrc

# ~/.config/fish/functions/create-envrc
function _git-envrc-event --on-variable="PWD"
  set -l red (set_color red)
  set -l normal (set_color normal)

  if ! test -f .envrc && git rev-parse --git-dir >/dev/null 2>/dev/null
    set envs .*-envrc
    if count $envs >/dev/null
      echo -n -s $red 'Error direnv: missing .envrc, run `create-envrc` to create .envrc from (ls .*-envrc)' $normal ' '
    end
  end
end