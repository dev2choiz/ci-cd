#!/usr/bin/env bash

configDir="$HOME/.kube"
configPath="$configDir/config"
export KUBECONFIG="$configPath"

if [ 1 == 2 ]; then
    # re-init master node
    sudo kubeadm reset -f
    sudo swapoff -a
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16  # flannel

    exit 0
fi

sudo rm -rf configDir
mkdir -p "$configDir"
sudo cp /etc/kubernetes/admin.conf "$configPath"
sudo chown $(id -u):$(id -g) "$configPath"
sudo chmod 777 "$configPath"


token="sudo "$(sudo kubeadm token create --print-join-command)  # flannel
mkdir -p ./logs
echo "$token" > ./logs/kubeadm_join_command
eval "$token"

sudo sysctl net.bridge.bridge-nf-call-iptables=1
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl taint nodes --all node-role.kubernetes.io/master-

kubectl config set-cluster val-cluster  --server=https://192.168.0.23:6443  --certificate-authority=./cert/ca-file
kubectl config set-cluster prod-cluster --server=https://192.168.0.23:6443  --certificate-authority=./cert/ca-file
kubectl config set-credentials developer --client-certificate=./cert/cert-file --client-key=./cert/key-seefile
kubectl config set-context validation --cluster=val-cluster --user=developer
kubectl config set-context production --cluster=prod-cluster --user=developer
