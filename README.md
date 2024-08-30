** Cluster Kubernetes / Flannel / Ceph / Kubeflow / ... **

Projeto: Cluster Kubernetes RTX 4090

Objetivo: Desenvolver um cluster Kubernetes robusto e escalável para atender às necessidades de treinamento de Inteligência Artificial (IA) e execução de containers, fornecendo tanto recursos dedicados para professores quanto ambientes controlados para alunos.

** Problema **

Com o aumento da demanda por recursos de computação de alta performance, especialmente em áreas de IA e aprendizado de máquina, é necessário criar uma infraestrutura que permita tanto o uso intensivo de GPUs quanto a gestão eficiente de recursos compartilhados em um ambiente educacional.

** Requisitos: **

    - Atender 40 máquinas equipadas com GPUs NVIDIA RTX 4090, exigindo uma infraestrutura capaz de gerenciar eficientemente o uso dessas GPUs.
    - Os Professores que precisam de acesso dedicado aos recursos do cluster, podendo alocar uma ou todas as máquinas para seus experimentos e treinamentos de IA.
    - Alunos que utilizarão containers com Jupyter Notebooks, necessitando de um ambiente isolado e seguro para execução de seus códigos sem impactar o desempenho global do cluster.
    - Gerenciamento de armazenamento distribuído eficiente para suportar as cargas de trabalho de IA, garantindo que os dados sejam acessíveis e replicados com alta disponibilidade.
    - Interfaces gráficas em cada máquina para permitir que os alunos acessem diretamente uma VM ao ligar o equipamento, facilitando o uso de recursos locais de cada máquina e não dar acesso direto aos recursos da máquina.

** Solução **

Para atender a esses requisitos, o projeto propõe a implementação de um cluster Kubernetes com as seguintes tecnologias e abordagens:

    CNI Flannel:
        Configuração do Flannel como o plugin de rede CNI para garantir uma comunicação eficiente e simples entre os pods no cluster.
        Escolha do Flannel por sua simplicidade e eficiência, adequada para o ambiente de alta performance com várias máquinas.

    Ceph para Gerenciamento de Armazenamento:
        Implementação do Ceph como solução de armazenamento distribuído, utilizando o operador Rook para facilitar a integração com o Kubernetes.
        Ceph permitirá a criação de volumes persistentes que são acessíveis por múltiplos pods, garantindo alta disponibilidade e resiliência dos dados.

    Rancher para Gerenciamento do Cluster:
        Instalação do Rancher para facilitar o gerenciamento do cluster Kubernetes, proporcionando uma interface gráfica intuitiva para administração e configuração do ambiente.
        O Rancher permitirá o gerenciamento centralizado de todos os recursos do cluster, simplificando tarefas como o deploy de aplicações e monitoramento.

    Kubeflow para Treinamento de IA e Gestão de Workflows:
        Implementação do Kubeflow para gerenciar o ciclo de vida dos treinamentos de IA, incluindo a enfileiração de tarefas e a execução de containers com Jupyter Notebook.
        Professores poderão utilizar todo o poder computacional disponível para grandes treinamentos, enquanto os alunos terão acesso a ambientes isolados para experimentação e aprendizado.

    VM com Interface Gráfica no host:
        Configuração de uma VM com interface gráfica em cada uma das 40 máquinas, permitindo que os alunos acessem diretamente um ambiente gráfico ao iniciar a máquina.
        Isso garante que os alunos não tenham acesso direto aos recursos das máquinas.

Conclusão

Este projeto visa criar uma infraestrutura de computação altamente flexível, escalável e eficiente para suportar tanto o ensino quanto a pesquisa em ambientes educacionais que demandam alto poder computacional. Com o uso combinado de Kubernetes, Ceph, Rancher, e Kubeflow, o cluster será capaz de atender às necessidades diversas de professores e alunos, otimizando o uso de recursos e garantindo um ambiente de aprendizado e pesquisa de ponta.

Este é apenas um prelúdio para o cluster das DGX ...
