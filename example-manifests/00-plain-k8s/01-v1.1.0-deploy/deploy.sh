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
echo "demo service v1.1.0 is listening at uat.demo.example.com:$nodeport"
echo "username: username"
echo "password: password"
