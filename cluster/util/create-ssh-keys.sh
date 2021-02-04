#!/bin/bash

ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa

kops create secret --name ${CLUSTER_NAME} sshpublickey admin -i ~/.ssh/id_rsa.pub


