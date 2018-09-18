#!/usr/bin/env bash

set -euxo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if ! kubectl get namespace demo
then
  kubectl create namespace demo
  kubectl label namespace demo istio-injection=enabled
fi

for f in $(ls $dir/*.yaml)
do
  kubectl apply -f $f
done

set +x

nodeport=$(kubectl get service knative-ingressgateway -n istio-system -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')

echo
echo "demo service v1.0.0 is listening at demo.demo.example.com:$nodeport"
