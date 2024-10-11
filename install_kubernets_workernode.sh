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
sudo apt-get install -y kubelet kubeadm

# Desativar swap (necessário para Kubernetes)
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


echo "Para adicionar o Worker Node ao cluster Kubernetes execute a linha de configuração forneceida pelo Master Node!"
