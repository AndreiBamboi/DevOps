#!/usr/bin/env bash
set -e
echo "This will script will copy a secret beetwen different namespace"
echo ""
echo "Bellow is the NS list from cluster"
NS_LIST="$(kubectl get ns | nl)"
echo "${NS_LIST}"
read -p "From the above list select NS to copy from (type NS line number): " from_ns
read -p "From the above list select NS to copy to (type NS line number): " to_ns
ns_from="$(kubectl get ns | sed -n "$from_ns p" | awk '{ print $1 }')"
ns_to="$(kubectl get ns | sed -n "$to_ns p" | awk '{ print $1 }')"

SECRET_LIST="$(kubectl get secrets -n $ns_from | nl)"
echo "---------------------------------"
echo "List of secrets from $ns_from namespace are: "
echo "${SECRET_LIST}"
echo ""
read -p "From above list select secret to copy (type line number): " secret_to_copy
secret="$(kubectl get secrets -n $ns_from | sed -n "$secret_to_copy p" | awk '{ print $1 }')"

echo "You will copy $secret secret from $ns_from ns to $ns_to ns"

read -p "Press Enter to continue" </dev/tty

kubectl get secret $secret -n $ns_from -o json | jq 'del(.metadata["namespace","creationTimestamp","resourceVersion","selfLink","uid","managedFields"])' | kubectl apply -n $ns_to -f -
if [ $? -eq 0 ]; then
  echo "Succesully created the secret"
else
  echo "Failed to create secret"
fi
