#!/bin/bash

# Script de configuração.
# Programas instalados:
#   - Git e configuração global na máquina
#   - Sistemas de pacotes Snap
#   - Spotify
#   - Python 
#   - VirtualBox
# Pré-requisitos:
#   - Script update.sh
cd ~/Downloads
echo "Installing user configs!"
  if [[ $# -eq 2 ]]; 
  then
    if ! (sudo apt-get install git -y && sudo apt-get install snapd -y && sudo snap install spotify && git config --global user.name ${1} && git config --global user.email ${2} && sudo wget https://go.microsoft.com/fwlink/?LinkID=760868 -O visualstudio.deb && sudo dpkg -i visualstudio.deb && sudo apt-get install python -y && sudo add-apt-repository multiverse && update.sh && sudo apt-get install virtualbox -y)
    then
      echo "Error on configs!"
      exit 1	
    fi;
  else 
    echo "Use: config.sh user.name(github) user.email(github)"
    exit 1 
  fi;
echo "Successfully configured." 