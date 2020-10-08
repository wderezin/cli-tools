
# RoleARN needs to be AWS ARN:  "arn:aws:iam::999999999999:role/UpdateApp" --role-session-name "David-ProdUpdate"
# Do script this in a loop
#
# for ARN in ARN1  ARN2 ARN3
# do
#   aws-assume-role $ARN
#   aws commands
# done

function aws-assume-role {
    ROLE_ARN=$1

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

    AWS_CREDS=$(aws sts assume-role --role-arn ${ROLE_ARN} $EXT_ID --role-session-name RoleSession${session} )
    ret=$?
    if [[ $ret == 0 ]]
    then
        [[ -n $VERBOSE ]] && printf "    Account: ${account}\n       Role: ${role}\n ExternalId: ${external_id}\n    RoleARN: ${roleARN}\n"
        export AWS_ASSUME_ROLE=${roleARN}
        prev_AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
        prev_AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
        prev_AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
        export AWS_ACCESS_KEY_ID="$(echo $AWS_CREDS | perl -ne 'print $1 if /"AccessKeyId":\s+"([^"]+)/' )"
        export AWS_SECRET_ACCESS_KEY="$(echo $AWS_CREDS | perl -ne 'print $1 if /"SecretAccessKey":\s+"([^"]+)/' )"
        export AWS_SESSION_TOKEN="$(echo $AWS_CREDS | perl -ne 'print $1 if /"SessionToken":\s+"([^"]+)/' )"
    else
        echo "ERROR: Failed to assume role" 1>&2
        return $ret
    fi
}