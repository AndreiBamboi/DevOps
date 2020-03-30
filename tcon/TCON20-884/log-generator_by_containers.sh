#!/usr/bin/env bash
ns=$(kubectl get ns| awk '{if (NR!=1){print $1}}')

for i in $ns
do
    export pods=$(kubectl get pod -n $i  | awk '{if (NR!=1){print $1}}') && \
    export current_ns=$i && \
    mkdir $i
    echo "Generating logs for containers in $current_ns namespace "
        for i in $pods
        do
            echo " Analyzing pod $i " && \
            export pod_name=$i
            export containers=$(kubectl get pod ${i} -n $current_ns -o jsonpath='{.spec.containers[*].name}')
            for i in $containers
            do
                export filename=${current_ns}_${pod_name}_${i}.txt
                export count_pod_containers=""
                for i in $containers; do let 'count_pod_containers +=1';done
                echo "Pod $pod_name has the following containers $i counting $count_pod_containers"
                if [[ $count_pod_containers -gt 1 ]]
                then
                    kubectl logs -n $current_ns $pod_name -c $i  > ${current_ns}/${filename} && echo "Succesfully generated log file $filename" || echo "Failed to generate logs for $i in $pod_name from $current_ns namespace"
                else
                    kubectl logs -n $current_ns $pod_name > ${current_ns}/${filename} && echo "Succesfully generated log file $filename" || echo "Failed to generate logs for $i in $pod_name from $current_ns namespace"
                fi

            done
        done
        echo
        echo
        echo "Succesfully generated the logs for current cluster"
done

