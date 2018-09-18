.PHONY: build
build:
	scripts/build.sh

.PHONY: push
push: build
	scripts/push.sh

.PHONY: start-minikube
start-minikube:
	scripts/start-minikube.sh

.PHONY: install-traefik
install-traefik:
	scripts/install-traefik.sh

.PHONY: install-istio
install-istio:
	scripts/install-istio.sh

.PHONY: install-knative
install-knative:
	scripts/install-knative.sh
