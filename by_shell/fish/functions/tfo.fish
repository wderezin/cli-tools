
function tfo --wraps terraform --description 'alias tf=terraform'
    # Do not use command as we want the function if present
    terraform $argv | tee out
end
