#!/usr/bin/env bash
kubectl delete -f ./manifests/
kubectl delete ns opa
kubectl label ns kube-system openpolicyagent.org/webhook-
rm -rf ./tls
rm -rf ./manifests/webhook-configuration.yaml
