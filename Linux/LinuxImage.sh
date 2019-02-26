#!/bin/bash

# This script creates an image with the files present in Software.txt for Ubuntu 18.04.
# This code presents parts that are properly commented out and separated by global variables,functions, and error issues.
# Version 2.3.2 - Tests, setting bugs on Software.txt

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
# All requirements have been successfully installed.
# Robo3T have a snap file. Solved the problem changing the install mode. [sudo snap install robo3t-snap]
# XAMPP successfully installed. Execute like sudo /opt/lampp/lampp start
# Cisco has to be the last one.
# PortugolStudio have another version (2.7.1) and works silent install.
# Still looking for ways to download scilab 
# Scilab is working now (any doubts use the link) - THIS GUY IS A GENIUS:  https://askubuntu.com/questions/1052962/scilab-5-5-2-on-ubuntu-18-04
#
# Softwares problems:
#    - Cisco Packett Tracer (Silent install - Try unattended mode)
#    - Line 281 - 	    Using echo for enter input
#    - Line 311		    Using echo for enter input 
#------------------------------------------------------------------------------------------------
# Global variables
#------------------------------------------------------------------------------------------------
ARGC=4
#------------------------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------------------------
#Update function: Update all repositories and packages.

sudo echo
function update(){
  echo "Updating all repositories..."
  if ! (sudo apt-get update -y && sudo apt-get dist-upgrade -y)
  then
      echo "Couldn't update all repositories and packages."
      exit 1
  fi;
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
  if [[ $# -eq ${ARGC} ]];
  then
	   wget -r ftp://${1}:${2}@${3}/${4}
	   mv /home/${USERNAME}/Downloads/${3}/${4} /home/${USERNAME}/Downloads
  else
   	echo "Four arguments are required, respectively: Username, password, FTP server IP address and path file. All arguments must be separated by space."
	exit 1
  fi;
}

#Erase function - Remove all files on the Downloads directory
function erase(){
  rm -rf ~/Downloads/*
  autoremove
}

#------------------------------------------------------------------------------------------------
# Installing requirements:

download $@
change
update

#Flash Player
echo "Installing Flash Player..."
  if ! (sudo sh -c "echo 'deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner' >> /etc/apt/sources.list" -y)
  then
    echo "The package containing the Flash Player couldn't be downloaded.."
    exit 1
  elif ! (update && sudo apt-get install adobe-flashplugin -y)
  then
    echo "Couldn't install Flash Player plugin."
    exit 1
  fi;
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
    fi;
  fi;
echo "Node.js and Npm successfully installed!"

#Alien
update
echo "Installing Alien..."
  if ! (sudo apt-get install alien -y)
    then
      echo "Couldn't install Alien."
      exit 1
  fi;
echo "Alien successfully installed!"

#Curl
update
echo "Installing Curl..."
  if ! (sudo apt-get install curl -y)
  then
    echo "Couldn't install the Curl package."
    exit 1
  fi;
echo "Curl successfully installed!"

#Git
update
echo "Installing Git..."
  if ! (sudo apt-get install git -y)
  then
    echo "Couldn't install git."
    exit 1
  fi;
echo "Git successfully installed!"

#Atom
update
echo "Installing Atom..."
  echo "Installing dependencies..."
  if ! (sudo apt-get install gconf2 -y && sudo apt-get install gconf-service -y)
  then
    echo "Couldn't download the dependencies."
    exit 1
  elif ! (sudo wget https://atom.io/download/deb && sudo dpkg -i deb)
  then
    echo "Couldn't install Atom."
    exit 1
  fi;
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
  fi;
echo "Cmake successfully installed!"

#Haskell compiler
update
change
echo "Installing Haskell compiler..."
  if ! (sudo apt-get install ghc -y)
  then
    echo "Couldn't install Haskell compiler."
    exit 1
  fi;
echo "Haskell compiler successfully installed!"

#Freeglut
update
echo "Installing Freeglut..."
  if ! (sudo apt-get install freeglut3 freeglut3-dev libglew1.5-dev libglew-dev libsoil-dev libsdl2-dev libsdl2-mixer-dev -y)
  then
    echo "Couldn't install Freeglut."
    exit 1
  fi;
echo "Freeglut successfully installed!"

#G++
update
echo "Installing g++..."
  if ! (sudo apt-get install g++ -y)
  then
    echo "Couldn't install g++."
    exit 1
  fi;
echo "G++ successfully installed!"

#Gcc
update
echo "Installing gcc..."
  if ! (sudo apt-get install gcc -y)
  then
    echo "Couldn't install gcc."
    exit 1
  fi;
echo "Gcc successfully installed!"

#Gedit
update
echo "Installing gedit..."
  if ! (sudo apt-get install gedit -y)
  then
    echo "Couldn't install gedit."
    exit 1
  fi;
echo "Gedit successfully installed!"

#GIMP
update
echo "Installing GIMP..."
  if ! (sudo apt-get install gimp -y)
  then
    echo "Couldn't install GIMP."
    exit 1
  fi;
echo "GIMP successfully installed!"

#Golang
update
echo "Installing Go compiler..."
  if ! (sudo apt-get install golang-go -y && sudo apt-get install gccgo-go -y)
  then
    echo "Couldn't install Go compiler."
    exit 1
  fi;
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
  fi;
echo "Google Chrome sucessfully installed!"
rm -rf google-chrome-stable_current_amd64.deb

#Interpretador Prolog
update
echo "Installing Prolog interpreter..."
  if ! (sudo apt-get install swi-prolog -y)
  then
    echo "Couldn't install Prolog interpreter."
    exit 1
  fi;
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
  fi;
  echo "Configuring JDK..."
  if ! (echo -e "2" | sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.2/bin/java 2 && sudo update-alternatives --config java)
  then
     echo "Couldn't configure JDK 11."
     exit 1
  fi;
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
echo "Installing JDK 8..."
  if ! (sudo add-apt-repository ppa:webupd8team/java -y)
  then
     echo "Couldn't install the requirement."
     exit 1
  elif ! (update && sudo apt-get install oracle-java8-installer -y)
  then
    echo "Unable to install JDK 8."
    exit 1
  elif ! (echo -e "Y" | sudo apt-get install oracle-java8-set-default -y)
  then
    echo "Couldn't configure JDK8."
    exit 1
  fi;
  echo "Verifying installation."
  java -version
echo "JDK 8 successfully installed!"

#Java3D
update
change
echo "Installing Java3D..."
  if ! (sudo apt-get install libjava3d-java -y)
  then
    echo "Couldn't install Java3D."
    exit 1
  fi;
echo "Java3D successfully installed!"

#LibreOffice
#Bug in here
update
echo "Installing LibreOffice..."
  echo "Purging LibreOffice!"
  if ! (sudo apt-get remove libreoffice-core --purge -y)
  then
    echo "Unable to uninstall LibreOffice."
    exit 1
  elif ! (sudo wget https://download.documentfoundation.org/libreoffice/stable/6.1.4/deb/x86_64/LibreOffice_6.1.4_Linux_x86-64_deb.tar.gz && tar -xvzf LibreOffice_6.1.4_Linux_x86-64_deb.tar.gz)
  then
    echo "Couldn't download LibreOffice."
    exit 1
  elif ! (cd LibreOffice_6.1.4.2_Linux_x86-64_deb/DEBS && sudo dpkg -i *.deb)
  then
    echo "Couldn't install LibreOffice."
    exit 1
  fi;
echo "LibreOffice successfully installed!"

#Mozilla Firefox
change
update
echo "Installing Mozilla Firefox..."
echo "Purging Mozilla Firefox!"
  if ! (sudo apt-get remove firefox --purge -y)
  then
    echo "Unable to uninstall Mozilla Firefox."
    exit 1
  elif ! (update && sudo apt-get install firefox -y)
  then
    echo "Couldn't install  Mozilla Firefox."
    exit 1
  fi;
echo "Mozilla Firefox successfully installed!"

#Octave
update
echo "Installing Octave..."
  if ! (sudo apt-get install octave -y)
  then
    echo "Couldn't install  Octave."
    exit 1
  fi;
echo "Octave successfully installed!"

#Python Anaconda
update
echo "Installing Anaconda..."
  cd /tmp/
  if ! (sudo curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh)
  then
    echo "Unable to donwload Anaconda's script."
    exit 1
  fi;
  if ! (bash Anaconda3-5.2.0-Linux-x86_64.sh -b)
  then
    echo "Unable to run Anaconda's script."
    exit 1
  fi;
  echo "PATH=$PATH:$HOME/anaconda3/bin" >> /home/${USERNAME}/.bashrc
  source ~/.bashrc
  conda -version
echo "Anaconda successfully installed!"

#Qt
change
update
echo "Installing Qt..."
#Creating a .qs script for no interaction of user
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
  if ! (sudo wget http://download.qt.io/official_releases/qt/5.12/5.12.1/qt-opensource-linux-x64-5.12.1.run && sudo chmod 755 qt-opensource-linux-x64-5.12.1.run)
  then
    echo "Unable to download Qt's script."
    exit 1
  elif ! (sudo ./qt-opensource-linux-x64-5.12.1.run --script qt-installer-noninteractive.qs)
  then
    echo "Unable to run Qt's script."
    exit 1
  fi;
echo "Qt successfully installed!"

#R
update
echo "Installing R..."
  if ! (sudo apt-get install r-base -y)
  then
    echo "Couldn't install R."
    exit 1
  fi;
echo "R successfully installed!"

#Sublime
update
change
echo "Installing Sublime..."
  if ! ((sudo wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -) && (echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list))
  then
    echo "Unable to install the requirements."
    exit 1
  elif ! (update && sudo apt-get install sublime-text -y)
  then
    echo "Couldn't install Sublime."
    exit 1
  fi;
echo "Sublime successfully installed!"

#TexStudio
update
echo "Installing TexStudio..."
  if ! (sudo apt-get install texstudio -y)
  then
    echo "Couldn't install TexStudio."
    exit 1
  fi;
echo "TexStudio successfully installed!"

#Grub Customizer
update
echo "Installing Grub Customizer..."
  if ! (sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y)
  then
    echo "Unable to install the requirements."
    exit 1
  elif ! (update && sudo apt-get install grub-customizer -y)
  then
    echo "Couldn't install Grub Customizer."
    exit 1
  fi;
echo "Grub Customizer successfully installed!"

autoremove
update
change

echo "All requirements are successfully installed!"
#------------------------------------------------------------------------------------------------
# All remains softwares
#------------------------------------------------------------------------------------------------

#OpenCV
# Unable to find the python3.5-dev package. Was replaced for python3.7-dev package.
# Using another version of libjasper. More information on: https://researchxuyc.wordpress.com/2018/09/26/install-libjasper-in-ubuntu-18-04/.
echo "Installing OpenCV..."
  echo "Installing requirements..."
    if ! (sudo apt-get install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev -y)
    then
	    echo "Unable to install requirements."
    	    exit 1
    elif ! (sudo apt-get install python3.7-dev python3-numpy libtbb2 libtbb-dev -y)
    then
	    echo "Unable to install requirements."
	    exit 1
    elif ! (sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && update && sudo apt-get install libjasper1 libjasper-dev -y)
    then
	    echo "Unable to install requirements."
	    exit 1
    elif ! (sudo apt-get install libjpeg-dev libpng-dev libtiff5-dev libdc1394-22-dev libeigen3-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev sphinx-common libtbb-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenexr-dev libgstreamer-plugins-base1.0-dev libavutil-dev libavfilter-dev libavresample-dev -y)
    then
	    echo "Unable to install requirements."
	    exit 1
    fi;
  echo "Requirements successfully installed!"
  echo "Running install routine."
  if ! (sudo -s && cd /opt && git clone https://github.com/Itseez/opencv.git && git clone https://github.com/Itseez/opencv_contrib.git && cd opencv && mkdir release && cd release && cmake -D BUILD_TIFF=ON -D WITH_CUDA=OFF -D ENABLE_AVX=OFF -D WITH_OPENGL=OFF -D WITH_OPENCL=OFF -D WITH_IPP=OFF -D WITH_TBB=ON -D BUILD_TBB=ON -D WITH_EIGEN=OFF -D WITH_V4L=OFF -D WITH_VTK=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules /opt/opencv/ && make -j4 && make install && ldconfig && change && pkg-config --modversion opencv)
  then
    	echo "Couldn't install OpenCV."
	exit 1
  fi;
echo "OpenCV successfully installed!"

update
change

#NetBeans and Gradle Support
# Installing Netbeans8.2 and Gradle Support. Failure on auto install Gradle Support Plugin
echo "Installing NetBeans 8.2..."
  if ! (cd /tmp && sudo wget -c http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh)
  then
	  echo "Unable to download the Netbeans script."
	  exit 1
  elif ! (chmod 755 netbeans-8.2-linux.sh && sudo ./netbeans-8.2-linux.sh --silent -y)
  then
	  echo "Couldn't install NetBeans."
	  exit 1
  fi;
  echo "Downloading Gradle Support."
  if ! (sudo wget https://github.com/kelemen/netbeans-gradle-project/releases/download/v2.0.2/netbeans-gradle-plugin-2.0.2.nbm)
  then
	  echo "Unable to download the plugin."
	  exit 1
  fi;
echo "Netbeans successfully installed and Gradle Support successfully downloaded!"

update
change

#Blender
#Simple install.
echo "Installing Blender..."
  if ! (sudo apt-get install blender)
  then
	  echo "Unable to download blender."
	  exit 1
  fi;
  update
echo "Blender successfully installed!"

update
change

#Visual Code
#Simple install.
echo "Installing VSCode..."
  if ! (sudo wget https://go.microsoft.com/fwlink/?LinkID=760868 -O visualstudio.deb && sudo dpkg -i visualstudio.deb)
  then
	  echo "Unable to install VSCode."
	  exit 1
  fi;
echo "Visual Code successfully installed!."

update
change

#Eletric
echo "Installing Eletric..."
  mkdir /home/${USERNAME}/Eletric
  cd /home/${USERNAME}/Eletric
  if ! (sudo wget https://ftp.gnu.org/pub/gnu/electric/electricBinary-9.07.jar -O electric.jar)
  then
   	echo "Unable to download Electric Java machine."
	  exit 1
  fi;
  cp electric.jar /usr/share/java/
  unzip electric.jar
  echo "Creating a .desktop file..."
  if ! (echo "[Desktop Entry]" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Type=Application" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Name=Electric" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "GenericName=Electric" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Path=/usr/share/java/" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Exec=java -jar /usr/share/java/electric.jar" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Icon=/home/${USERNAME}/Eletric/ElectricIcon64x64.png" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Terminal=False" >> /home/${USERNAME}/.local/share/applications/Electric.desktop)
  then
	  echo "Unable to create a .desktop file."
	  exit 1
  fi;
echo "Eletric successfully installed!"

update
change

#PostgreSQL
echo "Installing PostgreSQL..."
  if ! (chmod 755 postgresql-10.6-1-linux-x64.run && sudo ./postgresql-10.6-1-linux-x64.run --unattendedmodeui minimalWithDialogs --superaccount aluno --serviceaccount aluno --superpassword 123456 --mode unattended --prefix /opt/PostgreSQL/10 --datadir /opt/PostgreSQL/10/data)
  then
  	echo "Couldn't install PostgreSQL."
  	exit 1
  fi;
echo "PostgreSQL successfully installed!"

update
change

#IBM ILOG CPLEX
echo "Installing IBM ILOG CPLEX..."
  if ! (chmod 755 cplex_studio128.linux-x86-64.bin && sudo ./cplex*.bin)
  then
	echo "Couldn't install IBM ILOG CPLEX."
	exit 1
  fi;
echo "IBM ILOG CPLEX successfully installed!"

update
change

#XMind
echo "Installing XMind..."
  if ! (sudo apt-get install libwebkitgtk-1.0-0 -y && sudo apt-get install lame -y)
  then
	  echo "Unable to install the requirements."
	  exit 1
  elif ! (sudo dpkg -i xmind-8-beta-linux_amd64.deb -y)
  then
	  echo "Couldn't install  XMind."
    exit 1
  fi;
echo "XMind successfully installed!"

update
change

#SQLDeveloper
echo "Installing SQLDeveloper..."
  if ! (sudo alien --scripts sqldeveloper*.rpm && sudo dpkg -i sqldeveloper*.deb && remover && sudo apt-get remove icedtea-*-plugin)
  then
	echo "Couldn't install SQLDeveloper."
	exit 1
  fi;
  sudo echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /home/${USERNAME}/.sqldeveloper/18.4.0/product.conf
  echo "Configuration successfully completed."
echo "SQLDeveloper successfully installed!"

update
change
remove

#Arduino IDE
echo "Installing Arduino IDE..."
  if ! (sudo wget https://downloads.arduino.cc/arduino-1.8.8-linux64.tar.xz && tar xvf arduino-1.8.8-linux64.tar.xz)
  then
    echo "Unable to download the package for Arduino IDE."
    exit 1
  elif ! (cd arduino*/ && sudo sh ./install.sh)
  then
    echo "Couldn't install Arduino IDE."
    exit 1
  fi;
echo "Arduino IDE successfully installed!"

#Arquivos de Eletrônica
echo "Files already present only move them from directory."
  mv /home/${USERNAME}/Downloads/ArquivosEletrotécnica /home/${USERNAME}/
  mv ArquivosEletrotécnica Arquivos\ Eletrotécnica
echo "Files on the right directory."

#Codeblocks
update
echo "Installing CodeBlocks..."
  if ! (sudo apt-get install codeblocks -y)
  then
    echo "Couldn't install CodeBlocks."
    exit 1
  fi;
echo "CodeBlocks successfully installed!"

#Eclipse
update
echo "Installing Eclipse..."
  if ! (sudo apt-get install eclipse -y)
  then
    echo "Couldn't install Eclipse."
    exit 1
  fi;
echo "Eclipse successfully installed!"

#MongoDB
update
echo "Installing MongoDB..."
  if ! (sudo apt-get install mongodb -y && sudo systemctl status mongodb && mongo --eval 'db.runCOmmand({ connectionStatus: 1 })')
  then
    echo "Couldn't install  MongoDB."
    exit 1
  fi;
echo "MongoDB successfully installed!"

#MyOpenLab
change
echo "Installing MyOpenLab..."
  if ! (sudo wget https://myopenlab.org/distribution_linux_3.11.0.zip -y && unzip distribution_linux_3.11.0.zip -d distribution_linux_3.11.0)
  then
    echo "Couldn't install  MongoDB."
    exit 1
  elif ! (cd distribution_linux_3.11.0/ && sudo sh ./start_linux)
  then
    echo "Couldn't install  MongoDB."
    exit 1
  elif ! (sudo update-java-alternatives --set \java-1.8.0-openjdk-$(dpkg --print-architecture))
  then
    echo "Couldn't configurate MongoDB with JDK 8."
    exit 1
  fi;
echo "MyOpenLab successfully installed!"

#NetLogo
update
change
echo "Installing NetLogo..."
  if ! (sudo wget https://ccl.northwestern.edu/netlogo/6.0.4/NetLogo-6.0.4-64.tgz)
  then
    echo "Unable to download the file NetLogo."
    exit 1
  elif ! (tar -xzvf NetLogo-6.0.4-64.tgz -C /home/${USERNAME}/ && cd ~/NetLogo\ 6.0.4/ && wget http://netlogoweb.org/assets/images/desktopicon.png)
  then
    echo "Unable to extract the NetLogo file."
    exit 1
  fi;
  echo "Creating a .desktop file..."
  echo "[Desktop Entry]
        Name= NetLogo
        GenericName=NetLogo
      	Path=/home/${USERNAME}/NetLogo\ 6.0.4/
      	Exec=/home/${USERNAME}/NetLogo\ 6.0.4/NetLogo
        Icon=/home/${USERNAME}/NetLogo\ 6.0.4/desktopicon.png
        Terminal=false
        Type=Application" >> /home/${USERNAME}/.local/share/applications/NetLogo.desktop
  echo "[Desktop Entry]
        Name= NetLogo3D
        GenericName=NetLogo
      	Path=/home/${USERNAME}/NetLogo\ 6.0.4/
      	Exec=/home/${USERNAME}/NetLogo\ 6.0.4/NetLogo
        Icon=/home/${USERNAME}/NetLogo\ 6.0.4/desktopicon.png
        Terminal=false
        Type=Application" >> /home/${USERNAME}/.local/share/applications/NetLogo3D.desktop
echo "NetLogo successfully installed!"

#Pentaho
update
echo "Installing Pentaho..."
    if ! (mkdir Pentaho && cd Pentaho && mkdir 3.1 && mkdir 3.2 && mkdir 3.3 && mkdir 3.4)
    then
      echo "Unable to create files."
      exit 1
    elif ! (cd 3.1 && wget https://sourceforge.net/projects/pentaho/files/Business%20Intelligence%20Server/6.1/biserver-ce-6.1.0.1-196.zip && unzip biserver-ce-6.1.0.1-196.zip && rm biserver-ce-6.1.0.1-196.zip)
		then
      echo "Unable to download Pentaho version 3.1."
      exit 1
    elif ! (cd ~/Downloads/Pentaho/3.2/ && wget https://sourceforge.net/projects/pentaho/files/Report%20Designer/6.1/prd-ce-6.1.0.1-196.zip && unzip prd-ce-6.1.0.1-196.zip && rm prd-ce-6.1.0.1-196.zip)
    then
      echo "Unable to download Pentaho version 3.2."
      exit 1
    elif ! (cd ~/Downloads/Pentaho/3.3/ && wget https://sourceforge.net/projects/mondrian/files/schema%20workbench/3.12.0/psw-ce-3.12.0.1-196.zip && unzip psw-ce-3.12.0.1-196.zip && rm psw-ce-3.12.0.1-196.zip &&)
    then
      echo "Unable to download Pentaho version 3.3."
      exit 1
    elif ! (cd ~/Downloads/Pentaho/3.4 && wget https://sourceforge.net/projects/pentaho/files/Data%20Integration/6.1/pdi-ce-6.1.0.1-196.zip && unzip pdi-ce-6.1.0.1-196.zip && rm pdi-ce-6.1.0.1-196.zip)
    then
      echo "Unable to download Pentaho version 3.4."
      exit 1
    fi;
    change
    mv Pentaho/ /home/${USERNAME}
echo "Pentaho successfully installed!"

#Pinta
update
change
echo "Installing Pinta..."
  if ! (sudo add-apt-repository ppa:pinta-maintainers/pinta-stable && update)
  then
    echo "Unable to install the requirements."
    exit 1
  elif ! (sudo apt-get install pinta -y)
  then
    echo "Unable to install Pinta."
    exit 1
  fi;
echo "Pinta successfully installed!"

#Portugol Studio
update
change
echo "Installing Portugol Studio..."
  if ! (mkdir PortugolStudio && cd ~/Downloads/PortugolStudio/ && wget https://github.com/UNIVALI-LITE/Portugol-Studio/releases/download/v2.7.1/portugol-studio-2.7.1-linux-x64.run.zip && unzip portugol-studio-2.7.1-linux-x64.run.zip && chmod 755 portugol-studio-2.7.1-linux-x64.run)
  then
    echo "Unable to download Portugol Studio file."
    exit 1
  elif ! (sudo ./portugol-studio-2.7.1-linux-x64.run --mode unattended && cd ~/Downloads/ && rm -rf PortugolStudio/)
    echo "Unable to install Portugol Studio."
    exit 1
  fi;
echo "Portugol Studio successfully installed!"

#Project Libre
update
change
echo "Installing Project Libre..."
  if ! (sudo wget https://ufpr.dl.sourceforge.net/project/projectlibre/ProjectLibre/1.8/projectlibre_1.8.0-1.deb -O projectlibre.deb && sudo dpkg -i projectlibre.deb && sudo apt-get install -f)
  then
    echo "Unable to install Project Libre."
    exit 1
  fi;
echo "Project Libre successfully installed!"

#Robo 3T
update
change
echo "Installing Robo 3T..."
  if ! (sudo snap install robo3t-snap)
  then
	echo "Unable to install Robo3T."
	exit 1
  fi;
echo "Robo3T successfully installed!"

update
#RPGBoss
echo "Installing RPGBoss..."
  cd /home/${USERNAME}/
  if ! (sudo wget https://github.com/rpgboss/rpgboss/archive/v0.9.8.tar.gz && tar -xvf v0.9.8.tar.gz && cd rpgboss-0.9.8/ && ./gradlew run)
  then
  	echo "Unable to install RPGBoss."
  	exit 1
  elif ! (mv package/linux/rpgboss.desktop  ~/.local/share/applications/)
  then
  	echo "Preparing a .desktop file."
  	exit 1
  fi;
  echo "Updating the .desktop file."
  echo "[Desktop Entry]
        Name= RPGBoss game editor
        Exec=sh /home/${USERNAME}/rpgboss-0.9.8/package/linux/launch.sh
        Icon=/home/${USERNAME}/rpgboss-0.9.8/package/linux/icon.png
        Terminal=false
        Type=Application" > /home/${USERNAME}/.local/share/applications/rpgboss.desktop
echo "RPGBoss successfully installed!"

#RStudio
update
change
echo "Installing RStudio..."
  if ! (sudo wget https://download1.rstudio.org/rstudio-xenial-1.1.463-amd64.deb && sudo dpkg -i rstudio-xenial-1.1.463-amd64.deb)
  then
    echo "Unable to install RStudio."
    exit 1
  fi;
echo "RStudio successfully installed!"

#Scilab

update
change
echo "Installing Scilab..."
  if ! (mkdir Scilab && cd Scilab)
  then 
	echo "Unable to create a Scilab folder."
	exit 1
  elif ! (wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab_5.5.2-2ubuntu3_all.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-cli_5.5.2-2ubuntu3_all.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-data_5.5.2-2ubuntu3_all.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-doc_5.5.2-2ubuntu3_all.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-full-bin_5.5.2-2ubuntu3_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-include_5.5.2-2ubuntu3_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-minimal-bin_5.5.2-2ubuntu3_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-test_5.5.2-2ubuntu3_all.deb)
  then
	echo "Unable to download scilab files."
	exit 1
  elif ! (wget http://security.ubuntu.com/ubuntu/pool/universe/h/hdf5/libhdf5-10_1.8.16+docs-4ubuntu1.1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libsuitesparseconfig4.4.6_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libamd2.4.1_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/libm/libmatio/libmatio2_1.5.3-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libcamd2.4.1_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libccolamd2.9.1_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libcolamd2.9.1_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libcholmod3.0.6_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libumfpack5.7.1_4.4.6-1_amd64.deb)
  then
	echo "Unable to download scilab dependencies."
	exit 1
  elif ! (update && sudo apt-get install libcurl3 -y && sudo apt-get install ./lib*.deb -y && sudo apt-get install ./scilab*.deb -y && sudo apt-get install openjdk-8-jre openjdk-8-jre-headless -y)
  then
	echo "Unable to install the downloaded files."
	exit 1
  elif ! (sudo sed -i "s/^Exec=scilab -f$/Exec=env JAVA_HOME=\/usr\/lib\/jvm\/java-8-openjdk-$(dpkg --print-architecture)\/jre scilab -f/" /usr/share/applications/scilab.desktop && sudo sed -i "s/^Exec=scilab-adv-cli$/Exec=env JAVA_HOME=\/usr\/lib\/jvm\/java-8-openjdk-$(dpkg --print-architecture)\/jre scilab-adv-cli/" /usr/share/applications/scilab-adv-cli.desktop)
  then
	echo "Unable to install scilab."
	exit 1
  fi;
echo "Scilab successfully installed!"

#VirtualBox
update
change
echo "Installing VirtualBox..."
  if ! (sudo add-apt-repository multiverse && update)
  then
    echo "Unable to install the requirements."
    exit 1
  elif ! (sudo apt-get install virtualbox -y)
    echo "Unable to install VirtualBox."
    exit 1
  fi;
echo "VirtualBox successfully installed!"

#VLC
update
change
echo "Installing VLC..."
  if ! (sudo add-apt-repository ppa:videolan/master-daily)
  then
    echo "Unable to get the repository."
    exit 1
  elif ! (sudo apt-get install vlc -y)
  then
    echo "Unable to install VLC."
    exit 1
  fi;
echo "VLC successfully installed!"

#Wireshark
update
change
echo "Installing Wireshark..."
  if ! (sudo add-apt-repository ppa:wireshark-dev/stable && update)
  then
    echo "Unable to get the repository."
    exit 1
  elif ! (sudo apt-get install wireshark -y)
    echo "Unable to install Wireshark."
  fi;
echo "Wireshark successfully installed!"

#XAMP
update
change
echo "Installing XAMPP..."
  if ! (sudo wget https://www.apachefriends.org/xampp-files/7.3.1/xampp-linux-x64-7.3.1-0-installer.run && sudo chmod 755 xampp-linux-x64-7.3.1-0-installer.run && sudo ./xampp-linux-x64-7.3.1-0-installer.run --mode unattended --disable-components xampp_developer_files && sudo apt-get install net-tools -y)
  then
    echo "Unable to install XAMPP."
    exit 1
  fi;
echo "XAMPP successfully installed!"

update
change
#Cisco Packet Tracer
#Error on silent install: Enter Space Y Enter Enter Enter
echo "Installing Cisco Packet Tracer..."
  if ! (mkdir CiscoPacketTracer && cd CiscoPacketTracer/  && sudo tar -xzvf Packet*.tar.gz)
  then
  	echo "Unable to tar Cisco Packet Tracer."
  	exit 1
  elif ! (sudo ./install ) #Need quiet install
  then
  	echo "Unable to install Cisco Packet Tracer."
  	exit 1
  elif ! (cd /opt/bin/pt && ldd PacketTracer7 | grep "not found")
  then
  	echo "Not missing files or links."
  elif ! (sudo sh -c "echo 'deb http://security.ubuntu.com/ubuntu xenial-security main ' >> /etc/apt/sources.list" && update && sudo apt-get install libpng12-0 -y && sudo apt-get install libpng12-dev -y)
  then
  	echo "Solved the problem."
  	exit 1
  fi;
  echo "Creating a .desktop file"
  echo "[Desktop Entry]
        Name= Packettracer
        Comment=Networking
        GenericName=Cisco Packet Tracer
        Exec=/opt/packettracer/packettracer
        Icon=/usr/share/icons/packettracer.jpeg
        StartupNotify=true
        Terminal=false
        Type=Application" >> /home/${USERNAME}/.local/share/applications/PacketTracer.desktop
echo "Cisco Packett Tracer successfully installed!"
update
erase
