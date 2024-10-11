#!/bin/bash

# Atualizar pacotes e instalar dependências
sudo apt-get update && sudo apt-get install -y apt-transport-https curl

# Adicionar chave GPG do repositório do Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Adicionar repositório do Kubernetes
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Atualizar lista de pacotes e instalar Kubernetes
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# Desativar swap (necessário para Kubernetes)
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Inicializar o master node (modifique o CIDR conforme sua rede)
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Configurar o kubectl para o usuário atual
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Instalar plugin de rede (Flannel)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "Kubernetes Master instalado com sucesso! Guarde o token gerado para adicionar os nós ao cluster."