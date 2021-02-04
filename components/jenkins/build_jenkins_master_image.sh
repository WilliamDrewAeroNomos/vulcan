#!/bin/bash

# Builds image without cache

docker build --no-cache --pull -f Dockerfile-jenkins-master -t williamdrew/jenkins-master .
