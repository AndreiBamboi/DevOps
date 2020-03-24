#!/usr/bin/env bash
 export ns=$(kubectl get secrets  -A | grep mtr-pull-secret | awk '{print $1}')
for i in $ns; do  kubectl delete secret mtr-pull-secret -n $i && echo $i; done