#!/bin/bash

#kubeadm reset
rm -rf $HOME/.kube
rm -rf /var/etcd/*
#killall kubectl

kubeadm init --pod-network-cidr=192.168.0.0/16 --service-cidr 11.96.0.0/12
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl label nodes debianvaio master=master

#kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
kubectl apply -f calico.yaml
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl apply -f kubernetes-dashboard.rec.yaml

#kubectl proxy &
kubectl proxy --accept-hosts='.*' --address='0.0.0.0' &

kubectl create -f dashboard-admin.yaml


