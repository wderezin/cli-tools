
function tfswitch --wraps tfswitch --description 'alias tfswitch=tfswitch'
    if test (count *.tf) -eq 0
        echo "ERROR: Not in directory with .tf files, global terraform not allowed."
        return 1
    end

    if ! test -d .terraform
        mkdir .terraform
        tm-exclude .terraform
    end

    command tfswitch -b .terraform/terraform $argv 1>&2
end
