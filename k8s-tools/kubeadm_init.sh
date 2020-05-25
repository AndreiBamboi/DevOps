#!/usr/bin/env bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
kubec
apt-mark hold kubelet kubeadm kubectl docker.io
wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/
installation/hosted/rbac-kdd.yaml
wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/
installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml
kubeadm init --pod-network-cidr=192.168.0.0/16
kubectl apply -f rbac-kdd.yaml
kubectl apply -f calico.yaml
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubeadm reset
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*
sudo apt-get autoremove
sudo rm -rf ~/.kube
