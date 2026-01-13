#!/bin/bash

# O comando abaixo faz o script parar se houver qualquer erro
set -e

echo "--- Iniciando a instalação do Docker ---"

# 1. Atualiza a lista de pacotes
echo "Atualizando repositórios..."
sudo apt update

# 2. Instala dependências necessárias
echo "Instalando pré-requisitos..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# 3. Adiciona a chave GPG oficial do Docker
echo "Configurando chave GPG do Docker..."
# Remove a chave antiga se ela existir para evitar conflitos em re-instalações
sudo rm -f /usr/share/keyrings/docker-archive-keyring.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 4. Adiciona o repositório estável do Docker
echo "Adicionando repositório oficial..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Atualiza novamente e instala o Docker Engine
echo "Instalando Docker Community Edition..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 6. Adiciona o usuário atual ao grupo docker
echo "Configurando permissões para o usuário $USER..."
sudo usermod -aG docker $USER

echo "--- Instalação concluída com sucesso! ---"
echo "AVISO: Para que as mudanças de grupo façam efeito, saia da sessão (logout) e entre novamente."
