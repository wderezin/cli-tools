

function terraform --wraps terraform --description 'alias terraform=terraform'
    if command -q tfswitch
        if test (count *.tf) -gt 0

            test -d .terraform
            or mkdir .terraform

            if ! test -x .terraform/terraform
                command tfswitch -b .terraform/terraform </dev/null 2>/dev/null
                or echo "WARNING: required_version missing in .tf files"
            end
        end
    end

    if test -x .terraform/terraform
        .terraform/terraform $argv
    else if command -q terraform
        command terraform $argv
    else
        echo "terraform: not configured for project"
        return 1
    end
end