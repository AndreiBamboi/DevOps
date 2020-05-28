#!/usr/bin/env bash
shopt -s nocasematch
read -p "Are you using a custom repo ? yes/no:  " response
read -p "Enter chart name:  " chart_name
if [[ $response =~ yes ]]; then
    read -p "Enter you repo URL path:  " repo_path
    echo "Adding repo"
    helm repo add $(echo $chart_name | sed -e 's/\/.*//') $repo_path
    echo "Updating helm local repo"
    helm repo update
else
    echo "Updating helm local repo"
    helm repo update
fi
#Create dir for yamls
mkdir yamls
#Fetch template
echo "Fetch chart $chart_name"
helm fetch --untar --untardir . $chart_name
#Render templates yamls
echo "Generating yamls from $(echo $chart_name | sed -e 's/.*\///') chart"
helm template --output-dir './yamls' ./$(echo $chart_name | sed -e 's/.*\///')

