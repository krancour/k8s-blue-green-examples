#!/usr/bin/env bash

set -euxo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

kubectl scale deployment demo-v1-1-0 -n demo --replicas 3

for f in $(ls $dir/*.yaml)
do
  kubectl apply -f $f
done

kubectl delete destinationrule demo -n demo
kubectl delete deployment demo-v1-0-0 -n demo

set +x

nodeport=$(kubectl get service istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')

echo
echo "demo service v1.1.0 only is listening at demo.example.com:$nodeport"
