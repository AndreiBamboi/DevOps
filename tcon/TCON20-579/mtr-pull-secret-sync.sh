#!/usr/bin/bash
set -e
mtr-pull-secret_sync () {
    cluster_ns=$(kubectl get ns | awk '{if (NR!=1){print $1}}')
    excluded_ns="default kube-system kube-public kube-node-lease"
    filtered_ns=$(echo ${cluster_ns[@]} ${excluded_ns[@]} | tr ' ' '\n' | sort | uniq -u)
    secret="mtr-pull-secret"
    ns_no_secret=()
    echo "The following namespaces will be scanned for mtr-pull-secret: ${filtered_ns[@]}"
    echo
    for i in $filtered_ns
    do
      secret_name=$(kubectl get secrets -n $i | awk '{if (NR!=1){print $1}}')
      if [[ "${secret_name[@]}" =~ "$secret" ]]; then
        echo "$i namespace contain mtr-pull-secret"
      else
        echo "$i namespace does not contain mtr-pull-secret"
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
        echo "All namespaces scanned contain mtr-pull-secret"
    else
        echo "Namespaces without mtr-pull-secret are ${ns_no_secret[@]} and were updated with it"
    fi
}
mtr-pull-secret_sync