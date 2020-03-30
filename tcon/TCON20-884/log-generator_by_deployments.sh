#!/usr/bin/env bash
ns=$(kubectl get ns| awk '{if (NR!=1){print $1}}')

for i in $ns
do
    export deployments=$(kubectl get deployments -n $i  | awk '{if (NR!=1){print $1}}') && \
    export current_ns=$i && \
    mkdir $i
    echo "Generating logs for deployments in $current_ns namespace "
        for i in $deployments
        do
            echo " Analyzing deployment $i " && \
            dp_containers=$(kubectl get deployment $i -n $current_ns -o jsonpath='{.spec.template.spec.containers[*].name}')
            current_dp=$i
            echo "Deployment $i have the following containers: $dp_containers"
            for i in $dp_containers
            do
                export filename=${current_ns}_${current_dp}_${i}.txt
                kubectl logs -n $current_ns deployment/$current_dp -c $i > ${current_ns}/${filename} && \
                echo "Succesfully generated log file $filename for deployment $current_dp with container $i in $current_ns namespace"
            done
        done
    echo "Succesfully generated the logs"
done

