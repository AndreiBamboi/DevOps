#!/usr/bin/bash

#This script was built for ARGO CD resource hooks. It will start this script in a job container and add the required missing secret to each namespaces
# It will run on each ARGO app succesfully sync.
# For the job to succesfully run the necesary RBAC authorization need to be created before.
set -e
secret_sync () {
    cluster_ns=$(kubectl get ns | awk '{if (NR!=1){print $1}}')
    excluded_ns="default kube-system kube-public kube-node-lease"
    filtered_ns=$(echo ${cluster_ns[@]} ${excluded_ns[@]} | tr ' ' '\n' | sort | uniq -u)
    secret="required-secret" #Add your required secret. This script can be extended to a list of secrets and iterate on each one by adding and aditional for loop block.
    ns_no_secret=()
    echo "The following namespaces will be scanned for secret: ${filtered_ns[@]}"
    echo
    for i in $filtered_ns
    do
      secret_name=$(kubectl get secrets -n $i | awk '{if (NR!=1){print $1}}')
      if [[ "${secret_name[@]}" =~ "$secret" ]]; then
        echo "$i namespace contain secret"
      else
        echo "$i namespace does not contain secret"
        ns_no_secret=( "${ns_no_secret[@]}" "$i" )
        kubectl apply -f mtr-secret.yaml -n $i
        if [[ $? -ne 0 ]]; then
            echo "Update failed. Check logs"
            exit 1
        else
            echo "Namespace $i updated with $secret"
        fi
      fi
    done
        echo
    if [[ -z "$ns_no_secret" ]]; then
        echo "All namespaces scanned contain secret"
    else
        echo "Namespaces without required secret are ${ns_no_secret[@]} and were updated with it"
    fi
}
secret_sync