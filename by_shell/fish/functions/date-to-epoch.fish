
function date-to-epoch -a date_string
    set epoch (date "+%s" -d (echo $date_string | perl -pe 's/:(\d\d)$/\1/; s/T/ /') 2>/dev/null) # ubuntu
    or set epoch (date -j -f "%Y-%m-%d %H:%M:%S%z" (echo $date_string | perl -pe 's/:(\d\d)$/\1/; s/T/ /') +%s 2>/dev/null) #mac os x
    or set epoch (date -j -f "%s" $date_string +%s 2>/dev/null)
    or set epoch 0
    echo $epoch
end