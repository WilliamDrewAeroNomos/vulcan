#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Error: Incorrect number of parameters."
  echo "The following parameters are required:"
  echo "Arg #1 - secret name (i.e. - app-credentials)"
  echo "Arg #2 - user name (i.e. - jpublic)"
  echo "Arg #3 - password"
  echo "Example: > create_secret.sh app_credentials jpublic password"
  exit 2
fi

secretname=$1 
username=$2 
password=$3

htpasswd -bc httpwdoutput $username $password

echo "Creating secret "$secretname" from file httpwdoutput..."

kubectl create secret generic $secretname --from-file httpwdoutput

rm httpwdoutput
