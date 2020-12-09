function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _git_remote_name -a branch 
  echo (command git config --get branch.$branch.remote)
end

function _git_merge_name -a branch
  echo (command git config --get branch.$branch.merge | sed -e 's|^refs/heads/||')
end

function _git_ahead_behind_count -a branch remote merge
  command git rev-list --left-right --count $remote/$merge...$branch 2>/dev/null | string split --no-empty \t
end

function _git_print_local_change_count
  set -l count (git diff --name-only | wc -l | string trim)
  if test $count -eq 0
    echo ""
  else
    echo "△"$count
  end
end

function _git_print_path 

  # This allows overriding fish_prompt_pwd_dir_length from the outside (global or universal) without leaking it
  set -q fish_prompt_pwd_dir_length
  or set -l fish_prompt_pwd_dir_length 1

  set -q dare_prompt_git_path
  or set -l dare_prompt_git_path true

  if $dare_prompt_git_path
    set -l blue (set_color blue)
    set -l normal (set_color normal)

    set -l git_path_prefix (command git rev-parse --show-toplevel)

    echo -n 'git:'$blue(basename $git_path_prefix)

    # +2 to move just past /
    set -l tmp (string sub --start=(math (string length $git_path_prefix) + 2) $PWD)

    if test $fish_prompt_pwd_dir_length -eq 0
        echo -n /$tmp
    else
        # Shorten to at most $fish_prompt_pwd_dir_length characters per directory
        echo -n (string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' /$tmp)
    end
  else
    prompt_pwd
  end
end

function _git_print_branch_info -a branch remote merge
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l ab (_git_ahead_behind_count $branch $remote $merge)
  if test $ab[1] -gt 0; or test $ab[2] -gt 0
    # In a standard git branch
    set ab_color $yellow

    test $ab[1] -gt 0
    and set behind $ab[1]"－"
    and set ab_color $red

    test $ab[2] -gt 0
    and set ahead "＋"$ab[2]

    echo -n -s $normal '(' $ab_color $behind $branch  $ahead $normal ')' 
  else
    echo -n -s $normal '(' $green $branch  $normal ')' 
  end
end

function prompt_git
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l branch (_git_branch_name)
  set -l remote (_git_remote_name $branch)
  set -l merge (_git_merge_name $branch)

  set -q dare_prompt_seperator
  or set -l dare_prompt_seperator $normal' · '

  # Show git branch and status
  if test $branch; and test $remote
    # Tracked branch
    echo -n -s (_git_print_path)
    echo -n -s $dare_prompt_seperator
    echo -n -s (_git_print_branch_info $branch $remote $merge) 
    echo -n -s $normal (_git_print_local_change_count)
    return 0
  else if test $branch
    # Untrack branch
    echo -n -s (_git_print_path)
    echo -n -s $dare_prompt_seperator
    echo -n -s $red 'untracked(' $branch ')'
    echo -n -s $normal (_git_print_local_change_count)
    return 0
  else if git branch -l HEAD 2>/dev/null | grep 'detached' >/dev/null
    # Detached branch
    echo -n -s (_git_print_path) 
    echo -n -s $red '(detached)' 
    echo -n -s $normal (_git_print_local_change_count)
    return 0
  end

  return 1

end