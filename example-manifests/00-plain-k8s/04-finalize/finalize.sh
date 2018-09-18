#!/usr/bin/env bash

set -euxo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

kubectl scale deployment demo-v1-1-0 -n demo --replicas 3

for f in $(ls $dir/*.yaml)
do
  kubectl apply -f $f
done

kubectl delete ingress demo-uat -n demo
kubectl delete secret demo-uat-auth -n demo
kubectl delete service demo-v1-0-0 -n demo
kubectl delete deployment demo-v1-0-0 -n demo

set +x

nodeport=$(kubectl get service traefik -n traefik-system -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')

echo
echo "demo service v1.1.0 only is listening at demo.example.com:$nodeport"
