#!/bin/bash

kubectl apply -f 1-nginx-controller.yaml

./2-wait-for-pods.sh

kubectl apply -f 3-nginx-service.yaml

