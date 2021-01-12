

function terraform --wraps terraform --description 'alias terraform=terraform'
    if command -q tfswitch
        if test (count *.tf) -gt 0

            test -d .terraform
            or mkdir .terraform

            if ! test -x .terraform/terraform
                tfswitch -b .terraform/terraform
            end

            command .terraform/terraform $argv

        else if command -q terraform

            command terraform $argv

        else
            echo "ERROR: no .tf files or terraform in PATH"
            return 1
        end
    else
        command terraform $argv
    end
end