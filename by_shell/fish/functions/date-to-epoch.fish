
function date-to-epoch -a date_string
    set epoch (date -j -f "%Y-%m-%d %H:%M:%S%z" (echo $AWS_EXPIRATION | perl -pe 's/:(\d\d)$/\1/; s/T/ /') +%s 2>/dev/null)
    or set epoch (date -j -f "%s" $AWS_EXPIRATION +%s 2>/dev/null)
    or set epoch 0
    echo $epoch
end