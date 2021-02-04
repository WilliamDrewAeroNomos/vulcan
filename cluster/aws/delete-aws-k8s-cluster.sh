#!/bin/bash

# Deletes a K8S cluster using the values specified in set-env-vars.sh
# which are sourced here.

. ./set-env-vars.sh

echo "Deleting cluster $CLUSTER_NAME in region $REGION."
read -p "Do you want to continue? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

kops delete cluster ${CLUSTER_NAME} --yes

