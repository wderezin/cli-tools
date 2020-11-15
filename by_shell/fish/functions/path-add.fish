function path-add --description 'add to path only if it not already on path'
    test -d $argv; and ! contains $argv PATH; and set -p PATH $argv
end