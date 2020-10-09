

function aws-unassume-role {
# First unassume role if one has been assumed.
    if [[ -n $AWS_ASSUME_ROLE ]]
    then
        unset AWS_ASSUME_ROLE
        export AWS_ACCESS_KEY_ID=${prev_AWS_ACCESS_KEY_ID}
        export AWS_SECRET_ACCESS_KEY=${prev_AWS_SECRET_ACCESS_KEY}
        export AWS_SESSION_TOKEN=${prev_AWS_SESSION_TOKEN}
        [[ -z ${AWS_ACCESS_KEY_ID} ]] && unset AWS_ACCESS_KEY_ID
        [[ -z ${AWS_SECRET_ACCESS_KEY} ]] && unset AWS_SECRET_ACCESS_KEY
        [[ -z ${AWS_SESSION_TOKEN} ]] && unset AWS_SESSION_TOKEN
    fi
}