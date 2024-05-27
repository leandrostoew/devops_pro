#!/bin/bash

# Adiciona o PPA desejado
sudo add-apt-repository ppa:multipass/os-release

# Atualiza a lista de pacotes
sudo apt update

# Atualiza o sistema
sudo apt upgrade -y

