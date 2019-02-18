#!/bin/bash

# This script creates an image with the files present in Software.txt for Ubuntu 18.04.
# This code presents parts that are properly commented out and separated by global variables,functions, and error issues.
# Version 2.1.1 - Translating the files into English. Stop at JDK 8

#--------------------------------------------------------------------------------------------------
# Error Issues
#--------------------------------------------------------------------------------------------------
# Tar command have a -C option specifying the output directory.
# Problems in lines 295 to 300: A file was created and then moved using sudo and mv.
# Problem in line 327: Directory wasn't established correctly. The change function was used and the problem was solved.
# Anaconda's silent installation is done using the -b flag in the script.
# Using a silent Qt install script according to the link: https://stackoverflow.com/questions/25105269/silent-install-qt-run-installer-on-ubuntu-server 
# Conda list problem solved: echo "PATH=$PATH:$HOME/anaconda3/bin" >> /home/${USERNAME}/.bashrc and normal execution. 
# Line 637 introduces the creation of a .desktop file.

#-------------------------------------------------------------------------------------------------
# Suporte a erros
#----------------------------------------------------------------------------------
# All requirements have been successfully installed.
# Softwares problems:
#    - Cisco Packett Tracer and IBM ILOG CPLEX. (Lines 662 and 669)
#----------------------------------------------------------------------------------
# Global variables
#----------------------------------------------------------------------------------
ARGC=4 

#----------------------------------------------------------------------------------
# Functions
#----------------------------------------------------------------------------------
#Update function: Update all repositories and packages.

function update(){
  echo "Updating all repositories..."
  if ! (sudo apt-get update -y && sudo apt-get dist-upgrade -y) 
  then
      echo "Couldn't update all repositories and packages."
      exit 1
  fi
  echo "Successful update on all repositories and packages."
}

#Change function: Switches to the default user downloads directory.
function change(){
  cd /home/${USERNAME}/Downloads
}

#Autoremove function: Remove packages that are no longer needed.
function autoremove(){
  sudo apt autoremove -y
}

#Download function: Download files from the FTP server based on the script parameters and move those files to the Downloads folder.
function download(){
  if (${#} -eq ${ARGC})
  then
	wget -r ftp://${1}:${2}@${3}/${4}
	mv /home/${USERNAME}/Downloads/${4} /home/${USERNAME}/Downloads
  else
   	echo "Four arguments are required, respectively: Username,password,FTP server ip address and path file."
	exit 1
  fi;
}
#-------------------------------------------------------------------------------
# Installing requirements:

download
change
update

#Flash Player
echo "Installing Flash Player..."
  if ! sudo sh -c "echo 'deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner' >> /etc/apt/sources.list" -y
  then
    echo "The package containing the Flash Player couldn't be downloaded.."
    exit 1
  elif ! (update && sudo apt-get install adobe-flashplugin -y)
  then
    echo "Couldn't install Flash Player plugin."
    exit 1
  fi
echo "Flash Player successfully installed!"

#Node.js
update
echo "Installing Node.js and Npm..."
  if ! (sudo apt-get install nodejs -y && sudo apt-get install npm -y)
  then
    if ! (nodejs --version && npm --version)
    then
      echo "Couldn't install Node.js and Npm."
      exit 1
    fi
  fi
echo "Node.js and Npm successfully installed!"

#Alien
update
echo "Installing Alien..."
  if ! (sudo apt-get install alien -y)
    then
      echo "Couldn't install Alien."
      exit 1
  fi
echo "Alien successfully installed!"

#Curl
update
echo "Installing Curl..."
  if ! (sudo apt-get install curl -y)
  then
    echo "Couldn't install the Curl package."
    exit 1
  fi
echo "Curl successfully installed!"

#Git
update
echo "Installing Git..."
  if ! (sudo apt-get install git -y)
  then
    echo "Couldn't install git."
    exit 1
  fi
echo "Git successfully installed!"

#Atom
update
echo "Installing Atom..." 
  echo "Installing dependencies..."
  if ! (sudo apt-get install gconf2 -y && sudo apt-get install gconf-service -y)
  then
    echo "Couldn't download the dependencies."
    exit 1
  elif (sudo wget https://atom.io/download/deb && sudo dpkg -i deb)
  then
    echo "Couldn't install Atom."
    exit 1
  fi
echo "Atom successfully installed!"
rm -rf deb

#Cmake
update
echo "Installing Cmake..."
  if ! (sudo wget https://github.com/Kitware/CMake/releases/download/v3.12.4/cmake-3.12.4.tar.gz && tar -xvf cmake-3.12.4.tar.gz)
  then
    echo "Couldn't download and unzip the Cmake file."
    exit 1
  elif ! (cd cmake-3.12.4/ && sudo ./bootstrap && sudo make && sudo make install)
  then
    echo "Couldn't install Cmake."
    exit 1
  fi
echo "Cmake successfully installed!"

#Haskell compiler
update
change
echo "Installing Haskell compiler..."
  if ! (sudo apt-get install ghc -y)
  then
    echo "Couldn't install Haskell compiler."
    exit 1
  fi
echo "Haskell compiler successfully installed!"

#Freeglut
update
echo "Installing Freeglut..."
  if ! (sudo apt-get install freeglut3 freeglut3-dev libglew1.5-dev libglew-dev libsoil-dev libsdl2-dev libsdl2-mixer-dev -y)
  then
    echo "Couldn't install Freeglut."
    exit 1
  fi
echo "Freeglut successfully installed!"

#G++
update
echo "Installing g++..."
  if ! (sudo apt-get install g++ -y)
  then
    echo "Couldn't install g++."
    exit 1
  fi
echo "G++ successfully installed!"

#Gcc
update
echo "Installing gcc..."
  if ! (sudo apt-get install gcc -y)
  then
    echo "Couldn't install gcc."
    exit 1
  fi
echo "Gcc successfully installed!"

#Gedit
update
echo "Installing gedit..."
  if ! (sudo apt-get install gedit -y)
  then
    echo "Couldn't install gedit."
    exit 1
  fi
echo "Gedit successfully installed!"

#GIMP
update
echo "Installing GIMP..."
  if ! (sudo apt-get install gimp -y)
  then
    echo "Couldn't install GIMP."
    exit 1
  fi
echo "GIMP successfully installed!"

#Golang
update
echo "Installing Go compiler..."
  if ! (sudo apt-get install golang-go -y && sudo apt-get install gccgo-go -y)
  then
    echo "Couldn't install Go compiler."
    exit 1
  fi
echo "Golang successfully installed!"

#Google Chrome
update
echo "Installing Google Chrome..."
  if ! (sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb)
  then
	echo "Couldn't add Google Chrome repository."
  	exit 1
  elif ! (update && sudo dpkg -i google-chrome-stable_current_amd64.deb)
  then
	echo "Couldn't install Google Chrome."
  	exit 1
  fi
echo "Google Chrome sucessfully installed!"
rm -rf google-chrome-stable_current_amd64.deb

#Interpretador Prolog
update
echo "Installing Prolog interpreter..."
  if ! (sudo apt-get install swi-prolog -y)
  then
    echo "Couldn't install Prolog interpreter."
    exit 1
  fi
echo "Prolog interpreter successfully installed!"

#JDK 11
echo "Installing JDK 11..."
cd /tmp
  echo "Installing requirements..."
  if ! (sudo wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x64_bin.deb)
  then
     echo "Couldn't install the requirements."
     exit 1
  elif ! (sudo dpkg -i jdk-11.0.2_linux-x64_bin.deb)
  then
     echo "Couldn't install JDK 11."
     exit 1
  fi
  echo "Configuring JDK..." #Nessa parte tem interação com usuário
  if ! (sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.2/bin/java 2 && sudo update-alternatives --config java)
  then
     echo "Couldn't configure JDK 11."
     exit 1
  fi
     sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-11.0.2/bin/jar 2
     sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-11.0.2/bin/javac 2
     sudo update-alternatives --set jar /usr/lib/jvm/jdk-11.0.2/bin/jar
     sudo update-alternatives --set javac /usr/lib/jvm/jdk-11.0.2/bin/javac
  echo "Configuration successfully completed!"
  java -version
  echo "Configuring environment variables..."
     echo 'export J2SDKDIR=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export J2REDIR=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export PATH=$PATH:/usr/lib/jvm/jdk-11.0.2/bin:/usr/lib/jvm/jdk-11.0.2/db/bin' >> /home/${USERNAME}/jdk.sh
     echo 'export JAVA_HOME=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export DERBY_HOME=/usr/lib/jvm/jdk-11.0.2/db' >> /home/${USERNAME}/jdk.sh
     sudo mv /home/${USERNAME}/jdk.sh /etc/profile.d/
     source /etc/profile.d/jdk.sh
  echo "Configuration of environment variables performed successfully!"
echo "JDK 11 successfully installed!"

#JDK 8
update
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

#OpenCV 
# Pacote python3.5-dev desativado. Foi substituído pelo pacote python3.7-dev.
# Biblioteca libjasper-dev necessária para funcionamento não estava disponível no Ubuntu 18.04,portanto é necessário pegar de uma versão diferente, mais informações: https://researchxuyc.wordpress.com/2018/09/26/install-libjasper-in-ubuntu-18-04/.
#
echo "Instalando OpenCV..."
  echo "Instalando pré-requisitos..."
    if ! (sudo apt-get install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev)
    then
	echo "Falha ao instalar primeira parte dos requisitos."
	exit 1
    fi
    if ! (sudo apt-get install python3.7-dev python3-numpy libtbb2 libtbb-dev -y)
    then
	echo "Falha ao instalar segunda parte dos requisitos."
	exit 1
    fi
    if ! (sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && atualizar && sudo apt-get install libjasper1 libjasper-dev -y)
    then
	echo "Falha ao instalar biblioteca libjasper-dev."
	exit 1
    fi
    if ! (sudo apt-get install libjpeg-dev libpng-dev libtiff5-dev libdc1394-22-dev libeigen3-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev sphinx-common libtbb-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenexr-dev libgstreamer-plugins-base1.0-dev libavutil-dev libavfilter-dev libavresample-dev -y)
    then
	echo "Falha ao instalar a terceira parte dos requisitos."
	exit 1
    fi
  echo "Pré-requisitos instalados com sucesso!"
  echo "Começando a instalação do OpenCV."  
  if ! (sudo -s && cd /opt && git clone https://github.com/Itseez/opencv.git && git clone https://github.com/Itseez/opencv_contrib.git && cd opencv && mkdir release && cd release && cmake -D BUILD_TIFF=ON -D WITH_CUDA=OFF -D ENABLE_AVX=OFF -D WITH_OPENGL=OFF -D WITH_OPENCL=OFF -D WITH_IPP=OFF -D WITH_TBB=ON -D BUILD_TBB=ON -D WITH_EIGEN=OFF -D WITH_V4L=OFF -D WITH_VTK=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules /opt/opencv/ && make -j4 && make install && ldconfig && change && pkg-config --modversion opencv)
  then
    	echo "Falha ao instalar o OpenCV.Provavelmente no exit para sair da permissão de super usuário."
	exit 1
  fi
echo "OpenCV instalado com sucesso!"

atualizar
change

#NetBeans e Gradle Support
# Instalando NetBeans 8.2 IDE e também o Gradle Support,infelizmente o Gradle Support terá de ser feito na mão 
echo "Instalando o NetBeans 8.2..."
  if ! (cd /tmp && sudo wget -c http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh)
  then
	echo "Falha ao efetuar o download do script."
	exit 1
  fi
  if ! (chmod 755 netbeans-8.2-linux.sh && sudo ./netbeans-8.2-linux.sh --silent)
  then
	echo "Não foi possível instalar o NetBeans."
	exit 1
  fi
  change
  echo "Baixando o Gradle Support"
  if ! (sudo wget https://github.com/kelemen/netbeans-gradle-project/releases/download/v2.0.2/netbeans-gradle-plugin-2.0.2.nbm)
  then
	echo "Falha ao baixar o plugin"
	exit 1
  fi
echo "NetBeans instalado e Gradle Support baixado o arquivo (Tem que fazer na mão)!"

atualizar
change

#Blender
#Erros anteriores de dar update e upgrade não foram mais notados. 
echo "Instalando o Blender..."
  if ! (sudo apt-get install blender) 
  then
	echo "Falha ao baixar o Blender."
	exit 1
  fi
  if ! (atualizar)
  then
	echo "Falha ao dar upgrade no pacote do Blender"
	exit 1
  fi
echo "Blender instalado com sucesso!" 

atualizar
change

#Visual Code
#Erros apresentados anteriormente não estão sendo mais notados.
echo "Instalando o VSCode..."
  if ! (sudo wget https://go.microsoft.com/fwlink/?LinkID=760868 -O visualstudio.deb && sudo dpkg -i visualstudio.deb)
  then 
	echo "Falha ao instalar o VSCode."
	exit 1
  fi
echo "Visual Code instalado com sucesso!."

atualizar
change

#Eletric
echo "Instalando o Eletric..."
  mkdir /home/${USERNAME}/Eletric 
  cd /home/${USERNAME}/Eletric
  if ! (sudo wget https://ftp.gnu.org/pub/gnu/electric/electricBinary-9.07.jar -O electric.jar)
  then
   	echo "Falha ao baixar a máquina Java do Electric."
	exit 1
  fi
  cp electric.jar /usr/share/java/
  unzip electric.jar
  echo "Criando o .Desktop..."
  if ! (echo "[Desktop Entry]" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Type=Application" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Name=Electric" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "GenericName=Electric" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Path=/usr/share/java/" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Exec=java -jar /usr/share/java/electric.jar" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Icon=/home/${USERNAME}/Eletric/ElectricIcon64x64.png" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Terminal=False" >> /home/${USERNAME}/.local/share/applications/Electric.desktop)
  then
	echo "Falha ao criar atalho para o Electric."
	exit 1
  fi
echo "Eletric instalado com sucesso!"

atualizar
change

#PostgreSQL
echo "Instalando o PostgreSQL..."
  if ! (chmod 755 postgresql-10.6-1-linux-x64.run && sudo ./postgresql-10.6-1-linux-x64.run --unattendedmodeui minimalWithDialogs --superaccount aluno --serviceaccount aluno --superpassword 123456 --mode unattended --prefix /opt/PostgreSQL/10 --datadir /opt/PostgreSQL/10/data)
  then
	echo "Não foi possível instalar o PostgreSQL."
	exit 1
  fi
echo "PostgreSQL instalado com sucesso!"

atualizar
change

#Cisco Packett Tracer
echo "Instalando o Cisco Packett Tracer..."
echo "Cisco Packett Tracer instalado com sucesso!"

atualizar
change

#IBM ILOG CPLEX
echo "Instalando o IBM ILOG CPLEX..."
echo "IBM ILOG CPLEX instalado com sucesso!"

atualizar
change

#XMind
echo "Instalando o XMind..."
  if ! (sudo apt-get install libwebkitgtk-1.0-0 -y && sudo apt-get install lame -y)
  then
	echo "Não foi possível instalar pré-requisitos do XMind."
	exit 1
  fi
  if ! (sudo dpkg -i xmind-8-beta-linux_amd64.deb -y)
  then
	echo "Não foi possível instalar o XMind."
  fi
echo "XMind instalado com sucesso!"

atualizar
change

#SQLDeveloper
echo "Instalando o SQLDeveloper..."
  if ! (sudo alien --scripts sqldeveloper*.rpm && sudo dpkg -i sqldeveloper*.deb && remover && sudo apt-get remove icedtea-*-plugin)
  then
	echo "Não foi possível instalar o SQLDeveloper."
	exit 1
  fi
  sudo echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /home/${USERNAME}/.sqldeveloper/18.4.0/product.conf 
  echo "Configuração realizada com sucesso."
echo "SQLDeveloper instalado com sucesso!" 

atualizar
change
remove

echo "Término da Parte 2!"
exit 0
#-----------------------------------------------------------------------------
# Parte 3: Programas com instalação tranquila
#-----------------------------------------------------------------------------

atualizar
change

#Arduino IDE
echo "Instalando o Arduino IDE..."
  if ! (sudo wget https://downloads.arduino.cc/arduino-1.8.8-linux64.tar.xz && tar xvf arduino-1.8.8-linux64.tar.xz)
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


