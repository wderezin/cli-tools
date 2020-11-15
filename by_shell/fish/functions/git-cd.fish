function git-cd --description 'cd to root of current git repo'
    cd (git rev-parse --show-toplevel)/$argv
end
