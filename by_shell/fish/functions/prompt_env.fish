function prompt_env

    set -l ROOTDIR (git rev-parse --show-toplevel 2>/dev/null ;or echo .)

    if test -f $ROOTDIR/amplify/.config/local-env-info.json
        set -a env_info (jq -r '.envName' $ROOTDIR/amplify/.config/local-env-info.json)
        set -g AMPLIFY_ENV $env_info
    else
        set -e AMPLIFY_ENV
    end

    if test -f $ROOTDIR/knotlove.gen.ts
     set -a env_info (perl -ne 'if (/configuration\s*:\s*"([^"]+)"/) { print "$1\n"; exit }'  $ROOTDIR/knotlove.gen.ts )
    end

    if set -q env_info
        echo -n -s '<' (string join , $env_info) '>'
        return 0
    end

    return 1

end
