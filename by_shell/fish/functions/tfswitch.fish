
function tfswitch --wraps tfswitch --description 'alias tfswitch=tfswitch'
    if test (count *.tf) -eq 0
        echo "ERROR: Not in directory with .tf files, global terraform not allowed."
        return 1
    end

    test -d .terraform
    or mkdir .terraform

    command tfswitch -b .terraform/terraform $argv
end
