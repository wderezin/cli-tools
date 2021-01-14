function is-enabled
    if test (count $argv) -eq 0
        return 1
    end
    for x in $argv
        if ! string match -qr '^[0-9]+$' $x
            return 3
        end
        if test $x -eq 0
            return 2
        end
    end
    return 0
end