#!/usr/bin/env bash

set -euxo pipefail

helm repo update

helm install stable/traefik --name traefik --namespace traefik-system \
  --set serviceType=NodePort \
  --set dashboard.enabled=true \
  --set rbac.enabled=true
