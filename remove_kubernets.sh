#!/bin/bash

# Remover a configuração atual do kubeadm
echo "Resetando o kubeadm..."
sudo kubeadm reset -f

# Parar o serviço do kubelet e containerd
echo "Parando os serviços kubelet e containerd..."
sudo systemctl stop kubelet
sudo systemctl stop containerd

# Desmarcar os pacotes retidos
echo "Liberando pacotes mantidos do Kubernetes..."
sudo apt-mark unhold kubeadm kubectl kubelet

# Remover pacotes do Kubernetes
echo "Removendo pacotes do Kubernetes..."
sudo apt-get purge -y kubeadm kubectl kubelet
sudo apt-get autoremove -y

# Limpar diretórios residuais do Kubernetes
echo "Limpando diretórios residuais..."
sudo rm -rf ~/.kube
sudo rm -rf /etc/kubernetes
sudo rm -rf /var/lib/kubelet
sudo rm -rf /etc/cni
sudo rm -rf /opt/cni/bin

# Limpar arquivos do containerd relacionados ao Kubernetes
echo "Removendo configurações e dados do containerd relacionados ao Kubernetes..."
sudo rm -rf /var/lib/containerd

# Reiniciar o serviço containerd
echo "Reiniciando o serviço containerd..."
sudo systemctl restart containerd

echo "Remoção completa do Kubernetes finalizada!"
