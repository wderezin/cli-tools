# name: clearance
# ---------------
# Based on idan. Display the following bits on the left:
# - Virtualenv name (if applicable, see https://github.com/adambrenecki/virtualfish)
# - Current directory name
# - Git branch and dirty state (if inside a git repo)

function dot-before
  if set -l output (eval $argv)
    echo -n -s ' · '
    echo -n -s $output
    return 0
  end
  return 1
end

function dot-after
  if eval $argv
    echo -n -s ' · '
    return 0
  end
  return 1
end

function fish_prompt
  set -l last_status $status

  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  # Output the prompt, left to right

  # Add a newline before new prompts
  echo -e ''

  dot-after prompt_account

  # Need to make global so prompt_git sees it
  set -q dare_prompt_git_path
  or set -g dare_prompt_git_path true

  if $dare_prompt_git_path
    if ! prompt_git
      # Print pwd or full path
      echo -n -s (prompt_pwd) $normal
    end
  else
    echo -n -s (prompt_pwd) $normal
    dot-before prompt_git
  end

  set -l prompt_color $red
  if test $last_status = 0
    set prompt_color $normal
    set ERROR_PROMPT ""
  else
    set ERROR_PROMPT "[$last_status]"
  end

  if test $USER = 'root'
    set PROMPT_CHAR '$'
  else
    set PROMPT_CHAR '#'
  end

  # Terminate with a nice prompt char
  echo -e ''
  echo -e -n -s $prompt_color "$ERROR_PROMPT" "$PROMPT_CHAR " $normal

end
