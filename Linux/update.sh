#!/bin/bash

echo "Updating..."
  if ! (sudo apt-get dist-upgrade -y && sudo apt-get update -y)
  then
     echo "Failed to update" 
     exit 1
  fi;
echo "Success!"
