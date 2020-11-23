function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function _git_ahead_behind_count
   string split --no-empty \t (git rev-list --left-right --count origin/master...@)
end

function dot
  echo -n -s ' · '
end

function prompt_git
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  # This allows overriding fish_prompt_pwd_dir_length from the outside (global or universal) without leaking it
  set -q fish_prompt_pwd_dir_length
  or set -l fish_prompt_pwd_dir_length 1

  set -q dare_prompt_git_path
  or set -l dare_prompt_git_path true

  set -q dare_prompt_git_ahead_behind_count
  or set -l dare_prompt_git_ahead_behind_count true

  # Show git branch and status
  if test (_git_branch_name)
    set -l git_branch (_git_branch_name)
    set -l git_path_prefix (command git rev-parse --show-toplevel)

    if $dare_prompt_git_path
      echo -n 'git:'(basename $git_path_prefix)
      # +2 to move just past /
      set -l tmp (string sub --start=(math (string length $git_path_prefix) + 2) $PWD)

      if test $fish_prompt_pwd_dir_length -eq 0
          echo -n $blue/$tmp$normal
      else
          # Shorten to at most $fish_prompt_pwd_dir_length characters per directory
          echo -n $blue(string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' /$tmp)$normal
      end

      dot
    end

    set ab (_git_ahead_behind_count)
    if test $ab[1] -gt 0; or test $ab[2] -gt 0
      set ab_color $yellow
      if $dare_prompt_git_ahead_behind_count
        set ab (_git_ahead_behind_count)

        test $ab[1] -gt 0
        and set behind $ab[1]"±"
        and set ab_color $red

        test $ab[2] -gt 0
        and set ahead "±"$ab[2]

      else

        if test $ab[1] -gt 0
          set behind "±"
          set ab_color $red
        end

        if test $ab[2] -gt 0
          set ahead "±"
        end

      end
      set git_info '(' $ab_color $behind $git_branch $ahead $normal ')'
    else
      set git_info '(' $green $git_branch $normal ')'
    end
    echo -n -s $git_info $normal

    return 0
  end

  return 1

end