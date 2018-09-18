#!/usr/bin/env bash

set -euxo pipefail

cpus=${MK_CPUS:-4}
memory=${MK_MEMORY:-8192}

minikube start \
	--vm-driver virtualbox \
	--cpus $cpus \
	--memory $memory \
	--disk-size 50g \
	--kubernetes-version=v1.11.1 \
	--extra-config=controller-manager.cluster-signing-cert-file="/var/lib/localkube/certs/ca.crt" \
	--extra-config=controller-manager.cluster-signing-key-file="/var/lib/localkube/certs/ca.key" \
	--extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook,DefaultTolerationSeconds,ValidatingAdmissionWebhook"

# Wait for the apiserver to start responding
scripts/wupiao.sh $(minikube ip) 8443 300

# With RBAC enabled, we need to give tiller adequate permissions to administer
# the cluster
kubectl create clusterrolebinding tiller-cluster-admin \
	--clusterrole=cluster-admin \
	--serviceaccount=kube-system:default

helm init

kubectl rollout status -w deployment/tiller-deploy --namespace=kube-system
