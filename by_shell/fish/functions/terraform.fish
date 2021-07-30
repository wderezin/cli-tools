

function terraform --wraps terraform --description 'alias terraform=terraform'
    if command -q tfswitch
        if test (count *.tf) -gt 0 && test (grep required_version *.tf | wc -l ) -gt 0

            if ! test -d .terraform
                mkdir .terraform
                tm-exclude .terraform
            end

            if ! test -x .terraform/terraform
                command tfswitch -b .terraform/terraform </dev/null 1>&2 2>/dev/null
                or echo "WARNING: required_version missing in .tf files"
            end
        end
    end

    if test -x tf_before
        ./tf_before &
    end

    if test -x .terraform/terraform
        .terraform/terraform $argv
    else if test -x ../.terraform/terraform
        ../.terraform/terraform $argv
    else if command -q terraform
        command terraform $argv
    else
        echo "terraform: not configured for project"
        return 1
    end

    if test -x tf_after
        ./tf_after
    end
end