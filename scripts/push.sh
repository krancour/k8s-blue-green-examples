#!/usr/bin/env bash

set -exo pipefail

for f in $(ls example-app)
do
  docker push ${DOCKER_REPO}blue-green-demo:$f
done
