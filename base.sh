#!/bin/bash

## SWAP

# delete swap from fstab

sudo sed -i '/swap/d' /etc/fstab

# disable swap

sudo swapoff -a

# delete swap file /swap.img

sudo rm /swap.img

## KUBETOOLS

# let iptables see bridged traffic

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# add kubernetes repo

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl

# add gpg key

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# add repo

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# install kubetools

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl
