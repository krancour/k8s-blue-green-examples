#!/usr/bin/env bash

set -euxo pipefail

helm install vendor/istio-1.0.2/install/kubernetes/helm/istio \
  --name istio --namespace istio-system \
  --set gateways.istio-ingressgateway.type=NodePort
