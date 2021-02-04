#!/bin/bash

# Runs image in container

docker run --publish 8000:8080 --detach --name jenkins williamdrew/jenkins-master
