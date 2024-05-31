#!/bin/bash

# Navega para o diretório do repositório
cd /home/leandro/devops_pro/

# Solicita uma mensagem para o commit
read -p "Digite a mensagem para o commit: " commit_message

# Adiciona todas as alterações ao commit
git add .

# Realiza o commit das alterações
git commit -m "$commit_message"

# Envia as alterações para o repositório remoto
git push origin main

echo "Alterações enviadas para o repositório remoto com sucesso!"

