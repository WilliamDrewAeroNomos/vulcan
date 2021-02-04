#!/bin/bash

# Builds image without cache

docker build --no-cache --pull -f Dockerfile -t williamdrew/hygieia-api .
