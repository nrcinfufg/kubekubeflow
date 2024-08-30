#!/bin/bash

# Roteiro de Configuração Automática de CNI Flannel e Ceph com Rook

# Verifica se o script está sendo executado no master node
if [ "$(hostname)" != "kubeserver" ]; then
  echo "Este script deve ser executado no master node (kubeserver)."
  exit 1
fi

# Passo 1: Configuração do CNI Flannel
echo "Instalando CNI Flannel..."
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
echo "Flannel instalado com sucesso."

# Verificar o status dos nós
echo "Verificando o status dos nós..."
kubectl get nodes
