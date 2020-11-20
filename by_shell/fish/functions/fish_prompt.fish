# name: clearance
# ---------------
# Based on idan. Display the following bits on the left:
# - Virtualenv name (if applicable, see https://github.com/adambrenecki/virtualfish)
# - Current directory name
# - Git branch and dirty state (if inside a git repo)

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l last_status $status

  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l cwd $blue(pwd | sed "s:^$HOME:~:")

  # Output the prompt, left to right

  # Add a newline before new prompts
  echo -e ''

  prompt_account

  # Print pwd or full path
  echo -n -s (prompt_pwd) $normal

  prompt_git

  set -l prompt_color $red
  if test $last_status = 0
    set prompt_color $normal
    set ERROR_PROMPT ""
  else
    set ERROR_PROMPT "[$last_status]"
  end

  if [ $USER = 'root' ]
  then
    set PROMPT_CHAR '$'
  else
    set PROMPT_CHAR '#'
  end

  # Terminate with a nice prompt char
  echo -e ''
  echo -e -n -s $prompt_color "$ERROR_PROMPT" "$PROMPT_CHAR " $normal

end
