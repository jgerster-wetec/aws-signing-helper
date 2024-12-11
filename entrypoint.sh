#!/usr/bin/env bash
set -e

if [ -z $PORT ]
then
  PORT="9911"
fi

if [ -z $SESSION_DURATION ]
then
  SESSION_DURATION="3600"
fi

if [ -z $REGION ]
then
  REGION="eu-north-1"
fi

if [ -z $ENDPOINT ]
then
  ENDPOINT="rolesanywhere.eu-north-1.amazonaws.com"
fi

if [ -z $DEBUG ]
then
  eEBUG=false
fi
aws_signing_helper serve --port $PORT --certificate $CERTIFICATE --private-key $PRIVATE_KEY --trust-anchor-arn $TRUST_ANCHOR_ARN --profile-arn $PROFILE_ARN --role-arn $ROLE_ARN --endpoint $ENDPOINT --region $REGION --debug $DEBUG &
# make signing helper service accessible to other containers inside docker network
socat tcp4-listen:$PORT,bind=aws-signing-helper,reuseaddr,fork tcp4:127.0.0.1:$PORT
