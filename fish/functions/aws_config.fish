function aws_config
  if not fgrep -q "[$argv]" ~/.aws/credentials
    echo "Please specify a valid profile."
  else

    set token_expired false

    if test $AWS_SESSION_EXPIRY
      set now (date +%s)
      # WARNING: this date command only works with GNU date
      set expiry (date -d $AWS_SESSION_EXPIRY +%s)

      if [ $now -gt $expiry ]
        set -e AWS_SESSION_EXPIRY
        set token_expired true
      end
    end

    if [ $token_expired = true ]
      set -e AWS_ACCESS_KEY_ID
      set -e AWS_SECRET_ACCESS_KEY
      set -e AWS_SESSION_TOKEN

      set account (awk "/\[$argv\]/,/^\$/ { if (\$1 == \"account_id\") { print \$3 }}" ~/.aws/credentials)
      set username (awk "/\[$argv\]/,/^\$/ { if (\$1 == \"username\") { print \$3 }}" ~/.aws/credentials)
      set mfarn "arn:aws:iam::$account:mfa/$username"
      set duration "43200"
      echo "Please enter your MFA token for $mfarn:"
      read -l mfa_token
      set aws_cli (aws --profile=$argv sts get-session-token \
      --serial-number="$mfarn" \
      --token-code=$mfa_token \
      --duration-seconds $duration \
      --output text \
      --query 'Credentials | join (`;`,values({ AccessKeyId: join(``, [`set -Ux AWS_ACCESS_KEY_ID `,AccessKeyId]), SecretAccessKey:join(``, [`set -Ux AWS_SECRET_ACCESS_KEY `,SecretAccessKey]), SessionToken:join(``, [`set -Ux AWS_SESSION_TOKEN `,SessionToken]), Expiration:join(``, [`set -Ux AWS_SESSION_EXPIRY `,Expiration]) }))' )

      fish -c $aws_cli
    end
  end
end
