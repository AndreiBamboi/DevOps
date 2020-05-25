#!/usr/bin/env bash
# Assume that all files are in the same directory as script.
set -xe
sudo kubeadm reset
sudo rm -rf /etc/cni/net.d && rm -rf ~/.kube
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f ./calico.yaml
kubectl apply -f ./admin.yaml
kubectl apply -f ./dashboard-all-in-one-nodeport.yaml
kubectl get svc -n kubernetes-dashboard


