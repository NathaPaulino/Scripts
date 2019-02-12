#!/bin/bash

# Script de criação de imagem para Ubuntu 18.04.
# ProgramList.txt contém todos os programas a serem instalados separados em partes que são referenciadas nos commits.
# Apresenta funções e trechos devidamente comentados. 
# Versão de teste 2.0 - Parte 1 testada e funcionando com sucesso. Iniciar script da parte 2 e pausar script da parte 3. 
# Descoberta do -C através do comando tar que permite escolher o diretório output
# Problema nas antigas linhas 297 - 301 (atualmente linhas 307 a 312) resolvido: Foi criado um arquivo no diretório atual e este depois movido com a pasta no qual precisava estar com os comandos sudo mv
# Problema na antiga linha 327: Diretório não era estabecido corretamente. Foi utilizado a função change para consertar o problema.
# Instalação forçada do Anaconda pode ser feito com -b
# Qt instalado não interativamente criando um script de acordo com o link https://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server 
# Problema do conda list resolvido, echo "PATH=$PATH:$HOME/anaconda3/bin" >> /home/${USERNAME}/.bashrc e execução normal. 
#
#----------------------------------------------------------------------------------
# Suporte a erros
#----------------------------------------------------------------------------------
# 1ª Parte concluída sem erro.
# 2ª Parte - Começar ela e terminar o quanto antes.
# 3ª Parte - Iniciada, porém parada enquanto não terminar a parte 2
#----------------------------------------------------------------------------------
# Funções Gerais
#----------------------------------------------------------------------------------
#Função atualizar: Atualiza todos os repositórios e pacotes.
function atualizar(){
  echo "Atualizando repositórios..."
  if ! sudo apt-get update -y
  then
      echo "Não foi possível atualizar os repositórios. Verifique o arquivo /etc/apt/sources.list"
      exit 1
  fi
  echo "Atualização de repositórios feita com sucesso!"
  echo "Atualizando pacotes instalados..."
  if ! sudo apt-get dist-upgrade -y
  then
      echo "Não foi possível atualizar os pacotes."
      exit 1
  fi
  echo "Atualização dos pacotes realizada com sucesso!"
}

#Função change: Troca para o diretório padrão de Downloads.
function change(){
  cd /home/${USERNAME}/Downloads
}

#Função remover: Remove pacotes não mais necessários.
function remover(){
  sudo apt autoremove -y
}

#-------------------------------------------------------------------------------
# Instalação de programas:

#Assumindo permissões de usuário
sudo echo

change
atualizar

#Flash Player
echo "Instalando Flash Player..."
  if ! sudo sh -c "echo 'deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner' >> /etc/apt/sources.list" -y
  then
    echo "Não foi possível instalar o Flash Player."
    exit 1
  fi
atualizar
if ! sudo apt-get install adobe-flashplugin -y
then
    echo "Não foi possível baixar o plugin."
    exit 1
fi
echo "Flash Player instalado com sucesso!"

#Node.js
atualizar
echo "Instalando Node.js e Npm..."
  if ! sudo apt-get install nodejs -y
  then
    if ! nodejs --version
    then
      echo "Não foi possível instalar o Node.js."
      exit 1
    fi
  fi
  if ! sudo apt-get install npm -y
  then
    if ! npm --version
    then
      echo "Não foi possível instalar o npm."
      exit 1
    fi
  fi
echo "Node.js e Npm instalados com sucesso!"

#Alien
atualizar
echo "Instalando Alien..."
  if ! sudo apt-get install alien -y
    then
      echo "Não foi possível instalar o pacote Alien."
      exit 1
  fi
echo "Alien instalado com sucesso!"

#Curl
atualizar
echo "Instalando Curl..."
  if ! (sudo apt-get install curl -y)
  then
    echo "Não foi possível instalar o pacote Curl."
    exit 1
  fi
echo "Curl instalado com sucesso!"

#Git
atualizar
echo "Instalando Git..."
  if ! sudo apt-get install git-all -y
  then
    echo "Não foi possível instalar o git."
    exit 1
  fi
echo "Git instalado com sucesso!"

#Atom
atualizar
echo "Instalando o Atom..."
  echo "Instalando dependências do Atom..."
  if ! (sudo apt-get install gconf2 -y && sudo apt-get install gconf-service -y)
  then
    echo "Não foi possível instalar pré-requisitos do Atom."
  fi
  if ! (sudo wget https://atom.io/download/deb && sudo dpkg -i deb)
  then
    echo "Não foi possível instalar o Atom."
    exit 1
  fi

echo "Atom instalado com sucesso!"
rm -rf deb

#Cmake
atualizar
echo "Instalando o Cmake..."
  if ! (sudo wget https://github.com/Kitware/CMake/releases/download/v3.12.4/cmake-3.12.4.tar.gz && tar -xvf cmake-3.12.4.tar.gz)
  then
    echo "Não foi possível baixar e descompactar o arquivo Cmake."
    exit 1
  fi
cd cmake-3.12.4/
  if ! (sudo ./bootstrap && sudo make && sudo make install)
  then
    echo "Não foi possível instalar o Cmake."
    exit 1
  fi
echo "Cmake instalado com sucesso!"

#Compilador Haskell
atualizar
change
echo "Instalando o compilador de Haskell..."
  if ! (sudo apt-get install ghc -y)
  then
    echo "Não foi possível instalar o compilador de Haskell."
    exit 1
  fi
echo "Compilador de Haskell instalado com sucesso!"

#Freeglut
atualizar
echo "Instalando o Freeglut..."
  if ! (sudo apt-get install freeglut3 freeglut3-dev libglew1.5-dev libglew-dev libsoil-dev libsdl2-dev libsdl2-mixer-dev -y)
  then
    echo "Não foi possível instalar o Freeglut."
    exit 1
  fi
echo "Freeglut instalado com sucesso!"

#G++
atualizar
echo "Instalando o g++..."
  if ! (sudo apt-get install g++ -y)
  then
    echo "Não foi possível instalar o g++."
    exit 1
  fi
echo "G++ instalado com sucesso!"

#Gcc
atualizar
echo "Instalando o gcc..."
  if ! (sudo apt-get install gcc -y)
  then
    echo "Não foi possível instalar o gcc."
    exit 1
  fi
echo "Gcc instalado com sucesso!"

#Gedit
atualizar
echo "Instalando o gedit..."
  if ! (sudo apt-get install gedit -y)
  then
    echo "Não foi possível instalar o gedit."
    exit 1
  fi
echo "Gedit instalado com sucesso!"

#GIMP
atualizar
echo "Instalando o GIMP..."
  if ! (sudo apt-get install gimp -y)
  then
    echo "Não foi possível instalar o GIMP."
    exit 1
  fi
echo "GIMP instalado com sucesso!"

#Golang
atualizar
echo "Instalando o compilador de Go..."
  if ! (sudo apt-get install golang-go -y && sudo apt-get install gccgo-go -y)
  then
    echo "Não foi possível instalar o compilador de Go."
    exit 1
  fi
echo "Golang instalado com sucesso!"

#Google Chrome
atualizar
echo "Instalando o Google Chrome..."
if ! (sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb)
then
	echo "Não foi possível adicionar o repositório do Google Chrome."
  exit 1
fi
atualizar
if ! (sudo dpkg -i google-chrome-stable_current_amd64.deb)
then
	echo "Não foi possível instalar o Google Chrome."
  exit 1
fi
echo "Google Chrome instalado com sucesso!"
rm -rf google-chrome-stable_current_amd64.deb

#Interpretador Prolog
atualizar
echo "Instalando o interpretador de Prolog..."
  if ! (sudo apt-get install swi-prolog -y)
  then
    echo "Não foi possível instalar o interpretador de Prolog."
    exit 1
  fi
echo "Interpretador de Prolog instalado com sucesso!"

#JDK 8
atualizar
echo "Instalando o JDK 8..."
  if ! (sudo add-apt-repository ppa:webupd8team/java -y)
  then
	   echo "Não foi possível adicionar o repositório do JDK 8."
     exit 1
  fi
  atualizar
  if ! (sudo apt-get install oracle-java8-installer -y && sudo apt-get install oracle-java8-set-default -y)
  then
     echo "Não foi possível instalar JDK 8."
     exit 1
  fi
  echo "Verificando instalação"
  java -version
echo "JDK 8 instalado com sucesso!"

#JDK 11 - Deixar pra mais tarde
echo "Instalando o JDK 11..."
cd /tmp
  echo "Instalando pré-requisitos..."
    if ! (sudo wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x64_bin.deb)
    then
      echo "Não foi possível instalar os pré-requisitos."
      exit 1
    fi
  echo "Pré-requisitos instalados com sucesso!"
    if ! (sudo dpkg -i jdk-11.0.2_linux-x64_bin.deb)
    then
      echo "Não foi possível instalar o JDK 11."
      exit 1
    fi
  echo "Configurando o JDK 11..." #Nessa parte tem interação com usuário
    if ! (sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.2/bin/java 2 && sudo update-alternatives --config java)
    then
      echo "Não foi possível configurar o JDK 11."
      exit 1
    fi
    sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-11.0.2/bin/jar 2
    sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-11.0.2/bin/javac 2
    sudo update-alternatives --set jar /usr/lib/jvm/jdk-11.0.2/bin/jar
    sudo update-alternatives --set javac /usr/lib/jvm/jdk-11.0.2/bin/javac
  echo "Configuração realizada com sucesso!"
  java -version
  echo "Configurando variáveis de ambiente..."
     echo 'export J2SDKDIR=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export J2REDIR=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export PATH=$PATH:/usr/lib/jvm/jdk-11.0.2/bin:/usr/lib/jvm/jdk-11.0.2/db/bin' >> /home/${USERNAME}/jdk.sh
     echo 'export JAVA_HOME=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export DERBY_HOME=/usr/lib/jvm/jdk-11.0.2/db' >> /home/${USERNAME}/jdk.sh
     sudo mv /home/${USERNAME}/jdk.sh /etc/profile.d/
    source /etc/profile.d/jdk.sh
  echo "Configuração de variáveis de ambiente realizada com sucesso!"
echo "JDK 11 instalado com sucesso!"

#Java3D
atualizar
change
echo "Instalando o Java3D..."
  if ! (sudo apt-get install libjava3d-java -y)
  then
    echo "Não foi possível instalar o Java3D."
    exit 1
  fi
echo "Java3D instalado com sucesso!"

#LibreOffice
atualizar
echo "Instalando o LibreOffice..."
  echo "Retirando LibreOffice que vem com o sistema operacional!"
  if ! (sudo apt-get remove libreoffice-core --purge -y)
  then
    echo "Não foi possível deinstalar o LibreOffice."
    exit 1
  fi
  if ! (sudo wget https://download.documentfoundation.org/libreoffice/stable/6.1.4/deb/x86_64/LibreOffice_6.1.4_Linux_x86-64_deb.tar.gz && tar -xvzf LibreOffice_6.1.4_Linux_x86-64_deb.tar.gz)
  then
    echo "Não foi possível baixar o LibreOffice."
    exit 1
  fi
  cd LibreOffice_6.1.4.2_Linux_x86-64_deb/DEBS
  if ! (sudo dpkg -i *.deb)
  then
    echo "Não foi possível instalar o LibreOffice."
    exit 1
  fi
echo "LibreOffice instalado com sucesso!"

#Mozilla Firefox
change
atualizar
echo "Instalando o Mozilla Firefox..."
echo "Desinstalando o Mozilla Firefox que vem com o sistema Operacional!"
  if ! (sudo apt-get remove firefox --purge -y)
  then
    echo "Não foi possível desinstalar o Mozilla Firefox."
    exit 1
  fi
atualizar
  if ! (sudo apt-get install firefox -y)
  then
    echo "Não foi possível instalar o Mozilla Firefox."
    exit 1
  fi
echo "Mozilla Firefox instalado com sucesso!"

#Octave
atualizar
echo "Instalando o Octave..."
  if ! (sudo apt-get install octave -y)
  then
    echo "Não foi possível instalar o Octave."
    exit 1
  fi
echo "Octave instalado com sucesso!"

#Python Anaconda
atualizar
echo "Instalando o Anaconda..." 
  cd /tmp/
  if ! (sudo curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh)
  then
    echo "Não foi possível baixar o script de instalação do Anaconda."
    exit 1
  fi
  if ! (bash Anaconda3-5.2.0-Linux-x86_64.sh -b) 
  then
    echo "Não foi possível rodar o script de instalação do Anaconda ou foi cancelado pelo usuário."
    exit 1
  fi
  echo "PATH=$PATH:$HOME/anaconda3/bin" >> /home/${USERNAME}/.bashrc
  source ~/.bashrc
  conda -version
echo "Anaconda instalado com sucesso!"

#Qt
change
atualizar
echo "Instalando o Qt..."
  if ! (sudo wget http://download.qt.io/official_releases/qt/5.12/5.12.1/qt-opensource-linux-x64-5.12.1.run && sudo chmod 755 qt-opensource-linux-x64-5.12.1.run)
  then
    echo "Não foi possível baixar o script de instalação do Qt ou alterar permissão do script."
    exit 1
  fi
#Criação do arquivo com o script não interativo .qs
  echo "function Controller() {
    installer.autoRejectMessageBoxes();
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton);
    })
}

Controller.prototype.WelcomePageCallback = function() {
    // click delay here because the next button is initially disabled for ~1 second
    gui.clickButton(buttons.NextButton, 3000);
}

Controller.prototype.CredentialsPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
    gui.currentPageWidget().TargetDirectoryLineEdit.setText(installer.value(\"HomeDir\") + \"/Qt\");
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    var widget = gui.currentPageWidget();

    widget.selectAll();
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function() {
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
    gui.clickButton(buttons.NextButton);
}
Controller.prototype.FinishedPageCallback = function() {
    gui.clickButton(buttons.FinishButton);
}" >> /home/ntic/Downloads/qt-installer-noninteractive.qs	
-------------------------------
  if ! (sudo ./qt-opensource-linux-x64-5.12.1.run --script qt-installer-noninteractive.qs)
  then
    echo "Não foi possível executar o script de instalação do Qt."
    exit 1
  fi
echo "Qt instalado com sucesso!"

#R
atualizar
echo "Instalando o R..."
  if ! (sudo apt-get install r-base -y)
  then
    echo "Não foi possível instalar o R."
    exit 1
  fi
echo "R instalado com sucesso!"

#Sublime
atualizar
change
echo "Instalando o Sublime..."
  if ! ((sudo wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -) && (echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list))
  then
    echo "Não foi possível instalar repositórios do Sublime."
    exit 1
  fi
atualizar
  if ! sudo apt-get install sublime-text -y
  then
    echo "Não foi possível instalar o Sublime."
    exit 1
  fi
echo "Sublime instalado com sucesso!"

#TexStudio
atualizar
echo "Instalando o TexStudio..."
  if ! sudo apt-get install texstudio -y
  then
    echo "Não foi possível instalar o TexStudio."
    exit 1
  fi
echo "TexStudio instalado com sucesso!"

#Grub Customizer
atualizar
echo "Instalando o Grub Customizer..."
  if ! (sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y)
  then
    echo "Não foi possível instalar o repositório do Grub Customizer."
    exit 1
  fi
  atualizar
  if ! (sudo apt-get install grub-customizer -y)
  then
    echo "Não foi possível instalar o Grub Customizer."
    exit 1
  fi
echo "Grub Customizer instalado com sucesso!"

remover
atualizar
change

#-----------------------------------------------------------------------------
# Parte 2: Programas com instalação complicada
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Parte 3: Programas com instalação tranquila
#-----------------------------------------------------------------------------
echo "Término da Parte 2!"
exit 0

atualizar
change

#Arduino IDE
echo "Instalando o Arduino IDE..."
  if ! (wget https://downloads.arduino.cc/arduino-1.8.8-linux64.tar.xz && tar xvf arduino-1.8.8-linux64.tar.xz)
  then
    echo "Não foi possível baixar o pacote do Arduino."
    exit 1
  fi
  cd arduino*/
  if ! (sudo sh ./install.sh)
  then
    echo "Não foi possível instalar o Arduino IDE."
    exit 1
  fi
echo "Arduino IDE instalado com sucesso!"

#Arquivos de Eletrônica

#Codeblocks
atualizar
echo "Instalando o CodeBlocks..."
  if ! sudo apt-get install codeblocks -y
  then
    echo "Não foi possível instalar o CodeBlocks."
    exit 1
  fi
echo "CodeBlocks instalado com sucesso!"

#Eclipse
atualizar
echo "Instalando o Eclipse..."
  if ! sudo apt-get install eclipse -y
  then
    echo "Não foi possível instalar o Eclipse."
    exit 1
  fi
echo "Eclipse instalado com sucesso!"

#MongoDB
atualizar
echo "Instalando o MongoDB..."
  if ! (sudo apt-get install mongodb -y && sudo systemctl status mongodb && mongo --eval 'db.runCOmmand({ connectionStatus: 1 })')
  then
    echo "Não foi possível instalar o MongoDB."
    exit 1
  fi
echo "MongoDB instalado com sucesso!"

#MyOpenLab
change
echo "Instalando o MyOpenLab..."
  if ! (sudo wget https://myopenlab.org/distribution_linux_3.11.0.zip -y && unzip distribution_linux_3.11.0.zip -d distribution_linux_3.11.0)
  then
    echo "Não foi possível instalar o MongoDB."
    exit 1
  fi
  cd distribution_linux_3.11.0/
  if ! (sudo sh ./start_linux)
  then
    echo "Não foi possível instalar o MongoDB."
    exit 1
  fi
  if ! (sudo update-java-alternatives --set \java-1.8.0-openjdk-$(dpkg --print-architecture))
  then
    echo "Não foi possível configurar o MongoDB para usar o JDK 8."
    exit 1
  fi 
echo "MyOpenLab instalado com sucesso!"

#NetLogo
atualizar
change
echo "Instalando o NetLogo..."
  if ! (sudo wget https://ccl.northwestern.edu/netlogo/6.0.4/NetLogo-6.0.4-64.tgz)
  then
    echo "Não foi possível baixar o tar do NetLogo."
    exit 1
  fi
  if ! tar -xf NetLogo-6.0.4-64.tgz -C /home/${USERNAME}/ 
  then
    echo "Não foi possível extrair o tar do NetLogo."
    exit 1
  fi 
#Criação do .desktop do NetLogo
  echo "Fazendo o .desktop..."
echo "NetLogo instalado com sucesso!"


