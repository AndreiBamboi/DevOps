#!/usr/bin/env bash
kubectl create ns opa
kubectl config set-context --current --namespace=opa
mkdir tls
./gen-rsa.sh
kubectl create secret tls opa-server --cert=./tls/server.crt --key=./tls/server.key
kubectl apply -f ./manifests/admission-controller.yaml
cat > ./manifests/webhook-configuration.yaml <<EOF
kind: ValidatingWebhookConfiguration
apiVersion: admissionregistration.k8s.io/v1beta1
metadata:
  name: opa-validating-webhook
  namespace: opa
  labels:
    app: opa
webhooks:
  - name: validating-webhook.openpolicyagent.org
    rules:
      - operations: ["CREATE", "UPDATE"]
        apiGroups: ["*"]
        apiVersions: ["*"]
        resources:
          - pods
          - services
          - replicasets
          - deployments
          - daemonsets
          - cronjobs
          - jobs
          - ingresses
          - roles
          - statefulsets
          - podtemplates
          - configmaps
          - secrets
    clientConfig:
      caBundle: $(cat ca.crt | base64 | tr -d '\n')
      service:
        namespace: opa
        name: opa
    namespaceSelector:
      matchExpressions:
      - {key: openpolicyagent.org/webhook, operator: NotIn, values: [ignore]}
EOF
kubectl label ns kube-system openpolicyagent.org/webhook=ignore
kubectl label ns opa openpolicyagent.org/webhook=ignore
kubectl apply -f ./manifests/webhook-configuration.yaml