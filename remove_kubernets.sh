#!/bin/bash

# Remover a configuração atual do kubeadm
echo "Resetando o kubeadm..."
sudo kubeadm reset -f

# Parar os serviços do kubelet e docker
echo "Parando os serviços kubelet e docker..."
sudo systemctl stop kubelet
sudo systemctl stop docker

# Remover pacotes do Kubernetes
echo "Removendo pacotes do Kubernetes..."
sudo apt-get purge -y kubeadm kubectl kubelet kubernetes-cni kube*
sudo apt-get autoremove -y

# Limpar diretórios residuais do Kubernetes
echo "Limpando diretórios residuais..."
sudo rm -rf ~/.kube
sudo rm -rf /etc/kubernetes
sudo rm -rf /var/lib/kubelet
sudo rm -rf /var/lib/etcd
sudo rm -rf /etc/cni
sudo rm -rf /opt/cni/bin

# Limpar arquivos do Docker relacionados ao Kubernetes
echo "Removendo configurações e dados do Docker relacionados ao Kubernetes..."
sudo rm -rf /var/lib/docker

# Reiniciar o sistema para garantir que todas as mudanças sejam aplicadas
echo "Reiniciando o sistema..."
sudo systemctl restart docker

echo "Remoção completa do Kubernetes finalizada!"
