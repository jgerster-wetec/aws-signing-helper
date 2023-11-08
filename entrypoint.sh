#!/usr/bin/env bash
set -e

if [ -z $PORT ]
then
  PORT="8081"
fi

if [ -z $SESSION_DURATION ]
then
  SESSION_DURATION="3600"
fi

if [ -z $REGION ]
then
  REGION="eu-west-1"
fi

if [ -z $ENDPOINT ]
then
  ENDPOINT="rolesanywhere.eu-west-1.amazonaws.com"
fi

if [ -z $DEBUG ]
then
  DEBUG=false
fi

aws_signing_helper serve --port $PORT --certificate $CERTIFICATE --private-key $PRIVATE_KEY --trust-anchor-arn $TRUST_ANCHOR_ARN --profile-arn $PROFILE_ARN --role-arn $ROLE_ARN --endpoint $ENDPOINT --region $REGION --debug $DEBUG
