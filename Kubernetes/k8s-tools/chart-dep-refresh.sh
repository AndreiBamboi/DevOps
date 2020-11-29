#!/bin/bash
if [[ -e ./Chart.lock ]]; then
  rm -rf ./charts/*
  rm -rf Chart.lock
  echo "Chart dependency removed"
else
  echo "Chart dependency not downloaded"
