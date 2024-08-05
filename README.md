## Índice

1. Instalação do Kubeberenet
2. configuração dos Nós Master
3. Configuracação dos Nós de Trabalho

## Kubebernet

Instalação do Kubernetes v1.30 no Ubuntu 22.04 Server

Este guia fornece instruções detalhadas sobre como instalar o Kubernetes v1.30 em um servidor Ubuntu 22.04.

**OBS:** O Kubelet não suporta o swap ativo, desative-o antes de continuar:

    sudo swapoff -a
    sudo sed -i '/ swap / s/^/#/' /etc/fstab

**Passo 1: Atualizar o índice de pacotes e instalar pacotes necessários**

  Primeiro, atualize o índice de pacotes e instale os pacotes necessários para usar o repositório apt do Kubernetes:

    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gpg

**Passo 2: Baixar a chave pública de assinatura para os repositórios de pacotes do Kubernetes**

  Baixe a chave pública de assinatura para os repositórios de pacotes do Kubernetes. A mesma chave de assinatura é usada para todos os repositórios, então você pode ignorar a versão na URL. Note que em lançamentos anteriores ao Debian 12 e Ubuntu 22.04, o diretório /etc/apt/keyrings não existe por padrão, e deve ser criado antes do comando curl.

    sudo mkdir -p -m 755 /etc/apt/keyrings
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

**Passo 3: Adicionar o repositório apt apropriado do Kubernetes**

  Adicione o repositório apt apropriado do Kubernetes. Por favor, note que este repositório tem pacotes apenas para o Kubernetes 1.30. Para outras versões menores do Kubernetes, você precisa mudar a versão menor do Kubernetes na URL para corresponder à sua versão menor desejada (você também deve verificar se está lendo a documentação para a versão do Kubernetes que você planeja instalar).

    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

**Passo 4: Atualizar o índice de pacotes apt, instalar kubelet, kubeadm e kubectl, e fixar suas versões**

  Atualize o índice de pacotes apt, instale o kubelet, kubeadm e kubectl, e fixe suas versões para evitar atualizações inesperadas:

    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl

**Passo 5: Instalar e Configurar Containerd**

  Instalar o Containerd

    sudo apt-get install -y containerd

  Configurar o Containerd

    sudo mkdir -p /etc/containerd
    sudo containerd config default | sudo tee /etc/containerd/config.toml
    sudo systemctl restart containerd
    sudo systemctl enable containerd

**Passo 6: Configurar o Kernel**

  Habilita o módulo br_netfilter

    sudo modprobe br_netfilter

  Aplica configurações sysctl necessárias:

    sudo bash -c 'cat <<EOF >/etc/sysctl.d/k8s.conf
    net.bridge.bridge-nf-call-iptables = 1
    net.bridge.bridge-nf-call-ip6tables = 1
    net.ipv4.ip_forward = 1
    EOF'
    sudo sysctl --system

**Passo 7: Habilitar e Iniciar o Serviço Kubelet**

    sudo systemctl enable --now kubelet

**Configuração dos Nós Master**

  **Primeiro Nó Master**
  Inicializar o Cluster

    sudo kubeadm init --control-plane-endpoint "10.0.0.100:6443" --upload-certs --pod-network-cidr=10.0.0.0/16

  Configurar Kubectl

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

  Instalar a Rede de Pod (Calico)

    kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

  Obter o Comando Kubeadm Join para Nós Master

    kubeadm token create --print-join-command --certificate-key $(kubeadm init phase upload-certs --upload-certs)

  **Segundo nó master**
  Adicionar o Segundo Nó Master

  No segundo nó master, execute o comando kubeadm join obtido no passo anterior:

    Exemplo: sudo kubeadm join 10.0.0.100:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash> --control-plane --certificate-key <certificate-key>

  **Configuração dos Nós de Trabalho**
  Obter o Comando Kubeadm Join do Primeiro Nó Master

  No primeiro nó master, obtenha o comando kubeadm join:

    kubeadm token create --print-join-command

  Nos nós de trabalho, execute o comando kubeadm join obtido no passo anterior:

    Exemplo: sudo kubeadm join 10.0.0.100:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>

  Verificar o Status do Kubelet

  Após inicializar o cluster ou unir o nó ao cluster, verifique o status do kubelet:

    sudo systemctl status kubelet
