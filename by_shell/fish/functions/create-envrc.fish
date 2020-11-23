#!/usr/bin/env fish

function create-envrc --description 'Create .envrc to include existing .*-envrc files'

  if test -f .envrc
    set -l red (set_color red)
    set -l normal (set_color normal)
    echo -n -s $red 'Error: .envrc already exist, `rm .envrc` first' $normal
    exit 1
  end

  for FILE in (ls .*-envrc 2>/dev/null)
    echo "source_env $FILE" >> .envrc
  end

  if test -f .envrc
    echo "Created .envrc"
  end

end
