echo $PrivateIP
echo $PublicIP
git clone https://github.com/docker-training/kube-essentials.git
cd ~/kube-essentials
chmod 777 *.sh
sudo ./install-docker.sh
ssh -t node1 "sudo bash" < ~/kube-essentials/install-docker.sh
ssh -t node2 "sudo bash" < ~/kube-essentials/install-docker.sh
echo " "
echo " "
echo "Installing k8s tools"
sudo ./install-k8s-tools.sh
ssh -t node1 "sudo -s && bash" < ~/kube-essentials/install-k8s-tools.sh
ssh -t node2 "sudo -s && bash" < ~/kube-essentials/install-k8s-tools.sh
token=$(kubeadm token generate)
echo $token
echo $token > token.hash
sudo kubeadm init --token $token \
	    --kubernetes-version 1.18.6 \
	        --apiserver-advertise-address $PrivateIP \
		    --pod-network-cidr 192.168.0.0/16
