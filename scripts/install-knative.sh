#!/usr/bin/env bash

set -euxo pipefail

curl -L https://github.com/knative/serving/releases/download/v0.1.1/release-lite.yaml \
  | sed 's/LoadBalancer/NodePort/' \
  | kubectl apply --filename -
