
function tfo --wraps terraform --description 'alias tf=terraform'
    terraform $argv | tee out
end
