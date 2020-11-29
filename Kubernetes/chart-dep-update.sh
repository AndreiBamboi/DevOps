#!/bin/bash
if [[ -e ./Chart.lock ]]; then
  rm -rf ./charts/*
  rm -rf Chart.lock
  echo "Chart dependency removed"
  helm dependency update
  echo "Latest chart source retreived from source"
  helm template .

else
  helm dependency update
  echo "Chart dependency not found local and downloaded from source"
  helm template .
fi
