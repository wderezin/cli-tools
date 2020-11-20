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

  # Display [venvname] if in a virtualenv
  if set -q VIRTUAL_ENV
      echo -n -s (set_color -b cyan black) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
  end

  # Print pwd or full path
  echo -n -s $cwd $normal

  # Show git branch and status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_is_dirty) ]
      set git_info '(' $yellow $git_branch "±" $normal ')'
    else
      set git_info '(' $green $git_branch $normal ')'
    end
    echo -n -s ' · ' $git_info $normal
  end

  if set -q AWS_PROFILE
    set -l -a acc_info $aws_access_color'AWS:'$AWS_PROFILE$normal
  end
  if set -q IBM_PROFILE
    set -l -a acc_info $yellow'IBM:'$IBM_PROFILE$normal
  end
  if [ (count $acc_info) -gt 0 ]
    set -l line (string join , $acc_info)
    echo -n -s ' · [' $line ']'
  end

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
