#!/usr/bin/env bash
OUTPUT="$(kubectl get cronjobs -A | nl)"
echo "Utility to run job on "
echo "Bellow are the cronjobs "
echo "${OUTPUT}"

read -p "From the above list , please type the number line of the cronjob:  " cronjob
read -p "Type a new prefix for the job , ex. test1:  " newjob
cronjob_choosen="$(kubectl get cronjobs -A | sed -n "$cronjob p" | awk '{ print $2 }')"
cronjob_namespace="$(kubectl get cronjobs -A | sed -n "$cronjob p" | awk '{ print $1 }')"
kubectl create job --from=cronjob/$cronjob_choosen $cronjob_choosen-$newjob -n $cronjob_namespace
