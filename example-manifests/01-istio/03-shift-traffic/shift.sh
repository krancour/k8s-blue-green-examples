#!/usr/bin/env bash

set -euxo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

kubectl scale deployment demo-v1-1-0 -n demo --replicas 2
kubectl scale deployment demo-v1-0-0 -n demo --replicas 2

for f in $(ls $dir/*.yaml)
do
  kubectl apply -f $f
done
