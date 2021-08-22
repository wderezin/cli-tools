
function date-to-epoch -a date_string

    if-linux echo (date "+%s" -d (echo $date_string | perl -pe 's/:(\d\d)$/\1/; s/T/ /') 2>/dev/null)
    or if-bsd echo (date -j -f "%Y-%m-%d %H:%M:%S%z" (echo $date_string | perl -pe 's/:(\d\d)$/\1/; s/T/ /') +%s 2>/dev/null)
    or if-bsd echo (date -j -f "%s" $date_string +%s 2>/dev/null)
    or echo 0

end