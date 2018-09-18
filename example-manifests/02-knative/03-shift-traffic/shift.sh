#!/usr/bin/env bash

set -euxo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

for f in $(ls $dir/*.yaml)
do
  kubectl apply -f $f
done

set +x

nodeport=$(kubectl get service knative-ingressgateway -n istio-system -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')

echo
echo "demo.demo.example.com:$nodeport now directs 50% of requests to v1.0.0 AND 50% of requests to v1.1.0"
