function git-root --description 'display the path to the root of the git project or current'
    git rev-parse --show-toplevel 2>/dev/null; or pwd
end