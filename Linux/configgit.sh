#!/bin/bash

if [[ $# -eq 2 ]]; 
  then
    if ! (git config user.name ${1} && git config user.email ${2})
    then
      echo "Erro em dados do github ou git não instalado."
      exit 1	
    fi;
else 
    echo "Use: config.sh user.name(github) user.email(github)"
    exit 1 
fi;
