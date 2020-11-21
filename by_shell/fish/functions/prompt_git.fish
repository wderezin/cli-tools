function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function prompt_git
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  if [ "$argv[1]" = "include_path" ]
    set include_path true
  else
    set include_path false
  end

  # Show git branch and status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set -l git_path_prefix (command git rev-parse --show-toplevel)

    if $include_path
      echo -n 'git:'(basename $git_path_prefix)
      set -l tmp (string replace -r '^'"$git_path_prefix"'($|/)' '' $PWD)

      if [ $fish_prompt_pwd_dir_length -eq 0 ]
          echo -n $blue'/'$tmp$normal
      else
          # Shorten to at most $fish_prompt_pwd_dir_length characters per directory
          echo -n $blue(string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' $tmp)$normal
      end

      dot-before
    end

    if [ (_git_is_dirty) ]
      set git_info '(' $yellow $git_branch "±" $normal ')'
    else
      set git_info '(' $green $git_branch $normal ')'
    end
    echo -n -s $git_info $normal

    return 0
  end

  return 1

end