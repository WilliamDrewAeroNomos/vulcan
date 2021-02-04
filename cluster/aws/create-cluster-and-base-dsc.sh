#!/bin/bash

. ./set-env-vars.sh

./create-aws-k8s-cluster.sh

kops validate cluster --wait 20m

cd ingress

./provision-ingress.sh

cd ..

kubectl apply -f elk/

cd ../../configs/base/

./provision-dsc.sh



