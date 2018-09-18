#!/usr/bin/env bash

set -exo pipefail

for f in $(ls example-app)
do
  docker build -t ${DOCKER_REPO}blue-green-demo:$f example-app/$f
done
