

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

    set tf_proxifier eval

    if contains $argv[1] plan apply destroy
        if set -q TF_PROXY_SERVER
            set port (random 10000 15000)
            aws-ec2-ssh -D $port -N $TF_PROXY_SERVER &
            sleep 3 # need to wait for ssh, switch to nc checking on port open

            set -x ALL_PROXY socks5://127.0.0.1:$port/
            set -x HTTPS_PROXY socks5://127.0.0.1:$port/
            set -x HTTP_PROXY socks5://127.0.0.1:$port/
        end

        if test -x tf_background
            ./tf_background &
        end
        if test -x tf_before
            ./tf_before
        end
    end

    if test -x .terraform/terraform
        $tf_proxifier .terraform/terraform $argv
    else if test -x ../.terraform/terraform
        $tf_proxifier ../.terraform/terraform $argv
    else if command -q terraform
        $tf_proxifier command terraform $argv
    else
        echo "terraform: not configured for project"
        return 1
    end

    if contains $argv[1] plan apply destroy
        if test -x tf_after
            ./tf_after
        end

        if jobs -p >/dev/null
            pkill -g (jobs -p)
        end
    end

end