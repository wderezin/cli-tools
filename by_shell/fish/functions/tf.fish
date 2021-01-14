
function tf --wraps terraform --description 'alias tf=terraform'
    # do not use command as we want to use the function if present
    terraform $argv
end
