function is-any-enabled
    if test (count $argv) -eq 0
        return 1
    end
    for x in $argv
        if string match -qr '^[0-9]+$' $x
            if test $x -gt 0
                return 0
            end
        end
    end
    return 2
end