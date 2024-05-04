
function amplify --wraps amplify --description 'alias amplify=amplify'
    withd (git-root) npx amplify $argv
end
