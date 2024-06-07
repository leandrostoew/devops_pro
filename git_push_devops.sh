#!/bin/bash

# Navega para o diretório do repositório
cd /home/leandro/devops_pro/

# Solicita uma mensagem para o commit
read -p "Digite a mensagem para o commit: " commit_message

# Adiciona todas as alterações ao commit
git add .

# Realiza o commit das alterações
git commit -m "$commit_message"

# Faz o pull das alterações remotas com rebase
git pull origin main --rebase

# Verifica se houve conflitos após o pull
if [ $? -eq 0 ]; then
    # Se não houver conflitos, continua com o push
    # Envia as alterações para o repositório remoto
    git push origin main
    echo "Alterações enviadas para o repositório remoto com sucesso!"
else
    # Se houver conflitos, exibe uma mensagem de erro e aborta o push
    echo "Erro: Houve conflitos ao puxar as alterações remotas. Por favor, resolva os conflitos e tente novamente."
fi

