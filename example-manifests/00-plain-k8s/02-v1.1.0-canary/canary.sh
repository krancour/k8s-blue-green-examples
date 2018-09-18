#!/usr/bin/env bash

set -euxo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

for f in $(ls $dir/*.yaml)
do
  kubectl apply -f $f
done

set +x

nodeport=$(kubectl get service traefik -n traefik-system -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')

echo
echo "demo.example.com:$nodeport now directs requests to v1.0.0 AND v1.1.0"
