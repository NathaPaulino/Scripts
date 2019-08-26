#!/bin/bash

function update(){
    if ! (sudo apt update -y && sudo apt upgrade -y) then
       echo "Não foi possível o update." 
    fi;
    echo "Repositórios atualizados com sucesso!"
}

function docker(){
    echo "Pré requisitos."
        sudo apt install apt-transport-https -y
        sudo apt install ca-certificates -y
        sudo apt install curl -y
        sudo apt install gnupg-agent -y
        sudo apt install software-properties-common -y
    
    echo "Chave do Docker."
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        update
        sudo apt install docker-ce docker-ce-cli containerd.io -y
    
    echo "Verificando instalação do Docker."
        sudo docker run hello-world
    
    echo "Comandos docker sem sudo."
	# sudo groupadd docker       
	# sudo usermod -aG docker ${USER}
        # newgrp docker
    
    echo "Configurando docker para inicializar com o sistema."
        # sudo systemctl enable docker

}

function kubernetes(){
    echo "Instalando o Kubectl."
        sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
        sudo chmod +x ./kubectl
        sudo mv ./kubectl /usr/local/bin/kubectl
    echo "Instalando os Pacotes"
        sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && sudo chmod +x minikube
        sudo install minikube /usr/local/bin
}

function autoremove(){
    sudo apt autoremove -y
}

docker
kubernetes
update
autoremove
