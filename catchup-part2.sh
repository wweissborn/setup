#!/bin/bash

cd kube-essentials
token=$(cat token.hash)
echo $token
cd
token_hash=$(cat discoverytoken.hash)
mkdir -p ~/.kube
sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
sudo chown ubuntu:ubuntu ~/.kube/config
kubectl apply -f ~/kube-essentials/kube-calico.yaml
ssh node1 \
	    "sudo kubeadm join \
	        --token $token $PrivateIP:6443 \
		    --discovery-token-ca-cert-hash $token_hash"
ssh node2 \
	    "sudo kubeadm join \
	        --token $token $PrivateIP:6443 \
		    --discovery-token-ca-cert-hash $token_hash"
kubectl get nodes --watch
