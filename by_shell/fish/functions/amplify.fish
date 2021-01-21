
function amplify --wraps amplify --description 'alias amplify=amplify'
    withd (git-root) command amplify $argv
end
