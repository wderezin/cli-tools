
function date-to-epoch -a date_string
    if if-linux
        date "+%s" -d (echo $date_string | perl -pe 's/:(\d\d)$/\1/; s/T/ /') 2>/dev/null
        # Formats on bsd Mac use strftime
    else if if-bsd
        if date -j -f "%Y-%m-%d %H:%M:%S%Z" (echo $date_string | perl -pe 's/:(\d\d)$/\1/; s/T/ /; s/Z/GMT/') +%s 2>/dev/null
            true
        else if date -j -f "%Y-%m-%d %H:%M:%S%z" (echo $date_string | perl -pe 's/:(\d\d)$/\1/; s/T/ /; s/:(\d+)$/\1/') +%s 2>/dev/null
            true
            # else if date -j -f "%s" $date_string +%s 2>/dev/null
            #     true
        else
            false
        end
    else
        false
    end
end
