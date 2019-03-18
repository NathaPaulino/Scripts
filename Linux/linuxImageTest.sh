#!/bin/bash

#Test mode on Virtual Images.
#The script has been divided on three parts (Requirements,Step One and Step Two) - The code will be tested for this way.
#This script have changes for the original.

#-----------------------------------------------------------------------------------------------------------------------
#Functions
#-----------------------------------------------------------------------------------------------------------------------
#Update Function

function update(){
  echo "Updating all repositories..." >> log.txt
  if ! (sudo apt-get update -y && sudo apt-get dist-upgrade -y)
  then
      echo "Couldn't update all repositories and packages." >> log.txt
      exit 1
  fi;
  echo "Successful update on all repositories and packages." >> log.txt
}

#Change Function
function change(){
    cd /home/$USERNAME/Downloads
}

#Autoremove Function
function autoremove(){
    sudo apt autoremove -y
}

#Erase Function
function erase(){
    rm -rf ~/Downloads/
    autoremove
}

#Download Function doesn't need for test on a Virtual Image. 
#-----------------------------------------------------------------------------------------------------------------------
# Requirements
#-----------------------------------------------------------------------------------------------------------------------

change
update
#Flash Player
echo "Installing Flash Player..." >> log.txt
  if ! (sudo sh -c "echo 'deb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner' >> /etc/apt/sources.list" -y)
  then
    echo "The package containing the Flash Player couldn't be downloaded." >> log.txt
    exit 1
  elif ! (update && sudo apt-get install adobe-flashplugin -y)
  then
    echo "Couldn't install Flash Player plugin." >> log.txt
    exit 1
  fi;
echo "Flash Player successfully installed!" >> log.txt

#Node.js
update
echo "Installing Node.js and Npm..." >> log.txt
  if ! (sudo apt-get install nodejs -y && sudo apt-get install npm -y)
  then
    if ! (nodejs --version && npm --version)
    then
      echo "Couldn't install Node.js and Npm." >> log.txt
      exit 1
    fi;
  fi;
echo "Node.js and Npm successfully installed!" >> log.txt

#Alien
update
echo "Installing Alien..." >> log.txt
  if ! (sudo apt-get install alien -y)
    then
      echo "Couldn't install Alien." >> log.txt
      exit 1
  fi;
echo "Alien successfully installed!" >> log.txt

#Curl
update
echo "Installing Curl..." >> log.txt
  if ! (sudo apt-get install curl -y)
  then
    echo "Couldn't install the Curl package." >> log.txt
    exit 1
  fi;
echo "Curl successfully installed!" >> log.txt

#Git
update
echo "Installing Git..." >> log.txt
  if ! (sudo apt-get install git -y)
  then
    echo "Couldn't install git." >> log.txt
    exit 1
  fi;
echo "Git successfully installed!" >> log.txt

#Atom
update
echo "Installing Atom..." >> log.txt
  echo "Installing dependencies..." >> log.txt
  if ! (sudo apt-get install gconf2 -y && sudo apt-get install gconf-service -y)
  then
    echo "Couldn't download the dependencies." >> log.txt
    exit 1
  elif ! (sudo wget https://atom.io/download/deb && sudo dpkg -i deb)
  then
    echo "Couldn't install Atom." >> log.txt
    exit 1
  fi;
echo "Atom successfully installed!" >> log.txt
rm -rf deb

#Cmake
update
echo "Installing Cmake..." >> log.txt
  if ! (sudo wget https://github.com/Kitware/CMake/releases/download/v3.12.4/cmake-3.12.4.tar.gz && tar -xvf cmake-3.12.4.tar.gz)
  then
    echo "Couldn't download and unzip the Cmake file." >> log.txt
    exit 1
  elif ! (cd cmake-3.12.4/ && sudo ./bootstrap && sudo make && sudo make install)
  then
    echo "Couldn't install Cmake." >> log.txt
    exit 1
  fi;
echo "Cmake successfully installed!" >> log.txt

#Haskell compiler
update
change
echo "Installing Haskell compiler..." >> log.txt
  if ! (sudo apt-get install ghc -y)
  then
    echo "Couldn't install Haskell compiler." >> log.txt
    exit 1
  fi;
echo "Haskell compiler successfully installed!" >> log.txt

#Freeglut
update
echo "Installing Freeglut..." >> log.txt
  if ! (sudo apt-get install freeglut3 freeglut3-dev libglew1.5-dev libglew-dev libsoil-dev libsdl2-dev libsdl2-mixer-dev -y)
  then
    echo "Couldn't install Freeglut." >> log.txt
    exit 1
  fi;
echo "Freeglut successfully installed!" >> log.txt

#G++
update
echo "Installing g++..." >> log.txt
  if ! (sudo apt-get install g++ -y)
  then
    echo "Couldn't install g++." >> log.txt
    exit 1
  fi;
echo "G++ successfully installed!" >> log.txt

#Gcc
update
echo "Installing gcc..." >> log.txt
  if ! (sudo apt-get install gcc -y)
  then
    echo "Couldn't install gcc." >> log.txt
    exit 1
  fi;
echo "Gcc successfully installed!" >> log.txt

#Gedit
update
echo "Installing gedit..." >> log.txt
  if ! (sudo apt-get install gedit -y)
  then
    echo "Couldn't install gedit." >> log.txt
    exit 1
  fi;
echo "Gedit successfully installed!" >> log.txt

#GIMP
update
echo "Installing GIMP..." >> log.txt
  if ! (sudo apt-get install gimp -y)
  then
    echo "Couldn't install GIMP." >> log.txt
    exit 1
  fi;
echo "GIMP successfully installed!" >> log.txt

#Golang
update
echo "Installing Go compiler..." >> log.txt
  if ! (sudo apt-get install golang-go -y && sudo apt-get install gccgo-go -y)
  then
    echo "Couldn't install Go compiler." >> log.txt
    exit 1
  fi;
echo "Golang successfully installed!" >> log.txt

#Google Chrome
update
echo "Installing Google Chrome..." >> log.txt
  if ! (sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb)
  then
	echo "Couldn't add Google Chrome repository." >> log.txt
  	exit 1
  elif ! (update && sudo dpkg -i google-chrome-stable_current_amd64.deb)
  then
	echo "Couldn't install Google Chrome." >> log.txt
  	exit 1
  fi;
echo "Google Chrome sucessfully installed!" >> log.txt
rm -rf google-chrome-stable_current_amd64.deb

#Interpretador Prolog
update
echo "Installing Prolog interpreter..." >> log.txt
  if ! (sudo apt-get install swi-prolog -y)
  then
    echo "Couldn't install Prolog interpreter." >> log.txt
    exit 1
  fi;
echo "Prolog interpreter successfully installed!" >> log.txt

#JDK 11
echo "Installing JDK 11..." >> log.txt
cd /tmp
  echo "Installing requirements..." >> log.txt
  if ! (sudo wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56e d3c/jdk-11.0.2_linux-x64_bin.deb)
  then
     echo "Couldn't install the requirements." >> log.txt
     exit 1
  elif ! (sudo dpkg -i jdk-11.0.2_linux-x64_bin.deb)
  then
     echo "Couldn't install JDK 11." >> log.txt
     exit 1
  fi;
  echo "Configuring JDK..." >> log.txt
  if ! (echo -e "2" | sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.2/bin/java 2 && sudo update-alternatives --config java)
  then
     echo "Couldn't configure JDK 11." >> log.txt
     exit 1
  fi;
     sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-11.0.2/bin/jar 2
     sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-11.0.2/bin/javac 2
     sudo update-alternatives --set jar /usr/lib/jvm/jdk-11.0.2/bin/jar
     sudo update-alternatives --set javac /usr/lib/jvm/jdk-11.0.2/bin/javac
  echo "Configuration successfully completed!" >> log.txt
  java -version
  echo "Configuring environment variables..." >> log.txt
     echo 'export J2SDKDIR=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export J2REDIR=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export PATH=$PATH:/usr/lib/jvm/jdk-11.0.2/bin:/usr/lib/jvm/jdk-11.0.2/db/bin' >> /home/${USERNAME}/jdk.sh
     echo 'export JAVA_HOME=/usr/lib/jvm/jdk-11.0.2' >> /home/${USERNAME}/jdk.sh
     echo 'export DERBY_HOME=/usr/lib/jvm/jdk-11.0.2/db' >> /home/${USERNAME}/jdk.sh
     sudo mv /home/${USERNAME}/jdk.sh /etc/profile.d/
     source /etc/profile.d/jdk.sh
  echo "Configuration of environment variables performed successfully!" >> log.txt
echo "JDK 11 successfully installed!" >> log.txt

#JDK 8
update
echo "Installing JDK 8..." >> log.txt
  if ! (sudo add-apt-repository ppa:webupd8team/java -y)
  then
     echo "Couldn't install the requirement." >> log.txt
     exit 1
  elif ! (update && sudo apt-get install oracle-java8-installer -y)
  then
    echo "Unable to install JDK 8." >> log.txt
    exit 1
  elif ! (echo -e "Y" | sudo apt-get install oracle-java8-set-default -y)
  then
    echo "Couldn't configure JDK8." >> log.txt
    exit 1
  fi;
  echo "Verifying installation." >> log.txt
  java -version
echo "JDK 8 successfully installed!" >> log.txt

#Java3D
update
change
echo "Installing Java3D..." >> log.txt
  if ! (sudo apt-get install libjava3d-java -y)
  then
    echo "Couldn't install Java3D." >> log.txt
    exit 1
  fi;
echo "Java3D successfully installed!" >> log.txt

#LibreOffice
#Bug in here
update
echo "Installing LibreOffice..." >> log.txt
  echo "Purging LibreOffice!" >> log.txt
  if ! (sudo apt-get remove libreoffice-core --purge -y)
  then
    echo "Unable to uninstall LibreOffice." >> log.txt
    exit 1
  elif ! (sudo wget https://download.documentfoundation.org/libreoffice/stable/6.1.4/deb/x86_64/LibreOffice_6.1.4_Linux_x86-64_deb.tar.gz && tar -xvzf LibreOffice_6.1.4_Linux_x86-64_deb.tar.gz)
  then
    echo "Couldn't download LibreOffice." >> log.txt
    exit 1
  elif ! (cd LibreOffice_6.1.4.2_Linux_x86-64_deb/DEBS && sudo dpkg -i *.deb)
  then
    echo "Couldn't install LibreOffice." >> log.txt
    exit 1
  fi;
echo "LibreOffice successfully installed!" >> log.txt

#Mozilla Firefox
change
update
echo "Installing Mozilla Firefox..." >> log.txt
echo "Purging Mozilla Firefox!" >> log.txt
  if ! (sudo apt-get remove firefox --purge -y)
  then
    echo "Unable to uninstall Mozilla Firefox." >> log.txt
    exit 1
  elif ! (update && sudo apt-get install firefox -y)
  then
    echo "Couldn't install  Mozilla Firefox." >> log.txt
    exit 1
  fi;
echo "Mozilla Firefox successfully installed!" >> log.txt

#Octave
update
echo "Installing Octave..." >> log.txt
  if ! (sudo apt-get install octave -y)
  then
    echo "Couldn't install  Octave." >> log.txt
    exit 1
  fi;
echo "Octave successfully installed!" >> log.txt

#Python Anaconda
update
echo "Installing Anaconda..." >> log.txt
  cd /tmp/
  if ! (sudo curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh)
  then
    echo "Unable to donwload Anaconda's script." >> log.txt
    exit 1
  fi;
  if ! (bash Anaconda3-5.2.0-Linux-x86_64.sh -b)
  then
    echo "Unable to run Anaconda's script." >> log.txt
    exit 1
  fi;
  echo "PATH=$PATH:$HOME/anaconda3/bin" >> /home/${USERNAME}/.bashrc
  source ~/.bashrc
  conda -version
echo "Anaconda successfully installed!" >> log.txt

#Qt
change
update
echo "Installing Qt..." >> log.txt
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
    echo "Unable to download Qt's script." >> log.txt
    exit 1
  elif ! (sudo ./qt-opensource-linux-x64-5.12.1.run --script qt-installer-noninteractive.qs)
  then
    echo "Unable to run Qt's script." >> log.txt
    exit 1
  fi;
echo "Qt successfully installed!" >> log.txt

#R
update
echo "Installing R..." >> log.txt
  if ! (sudo apt-get install r-base -y)
  then
    echo "Couldn't install R." >> log.txt
    exit 1
  fi;
echo "R successfully installed!" >> log.txt

#Sublime
update
change
echo "Installing Sublime..." >> log.txt
  if ! ((sudo wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -) && (echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list))
  then
    echo "Unable to install the requirements." >> log.txt
    exit 1
  elif ! (update && sudo apt-get install sublime-text -y)
  then
    echo "Couldn't install Sublime." >> log.txt
    exit 1
  fi;
echo "Sublime successfully installed!" >> log.txt

#TexStudio
update
echo "Installing TexStudio..." >> log.txt
  if ! (sudo apt-get install texstudio -y)
  then
    echo "Couldn't install TexStudio." >> log.txt
    exit 1
  fi;
echo "TexStudio successfully installed!" >> log.txt

#Grub Customizer
update
echo "Installing Grub Customizer..." >> log.txt
  if ! (sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y)
  then
    echo "Unable to install the requirements." >> log.txt
    exit 1
  elif ! (update && sudo apt-get install grub-customizer -y)
  then
    echo "Couldn't install Grub Customizer." >> log.txt
    exit 1
  fi;
echo "Grub Customizer successfully installed!" >> log.txt

autoremove
update
change

echo "All requirements are successfully installed!" >> log.txt
exit(1);

#Step One

#OpenCV
# Unable to find the python3.5-dev package. Was replaced for python3.7-dev package.
# Using another version of libjasper. More information on: https://researchxuyc.wordpress.com/2018/09/26/install-libjasper-in-ubuntu-18-04/.
echo "Installing OpenCV..." >> log.txt
  echo "Installing requirements..." >> log.txt
    if ! (sudo apt-get install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev -y)
    then
	    echo "Unable to install requirements." >> log.txt
    	    exit 1
    elif ! (sudo apt-get install python3.7-dev python3-numpy libtbb2 libtbb-dev -y)
    then
	    echo "Unable to install requirements." >> log.txt
	    exit 1
    elif ! (sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && update && sudo apt-get install libjasper1 libjasper-dev -y)
    then
	    echo "Unable to install requirements." >> log.txt
	    exit 1
    elif ! (sudo apt-get install libjpeg-dev libpng-dev libtiff5-dev libdc1394-22-dev libeigen3-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev sphinx-common libtbb-dev yasm libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenexr-dev libgstreamer-plugins-base1.0-dev libavutil-dev libavfilter-dev libavresample-dev -y)
    then
	    echo "Unable to install requirements." >> log.txt
	    exit 1
    fi;
  echo "Requirements successfully installed!" >> log.txt
  echo "Running install routine." >> log.txt
  if ! (sudo -s && cd /opt && git clone https://github.com/Itseez/opencv.git && git clone https://github.com/Itseez/opencv_contrib.git && cd opencv && mkdir release && cd release && cmake -D BUILD_TIFF=ON -D WITH_CUDA=OFF -D ENABLE_AVX=OFF -D WITH_OPENGL=OFF -D WITH_OPENCL=OFF -D WITH_IPP=OFF -D WITH_TBB=ON -D BUILD_TBB=ON -D WITH_EIGEN=OFF -D WITH_V4L=OFF -D WITH_VTK=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules /opt/opencv/ && make -j4 && make install && ldconfig && change && pkg-config --modversion opencv)
  then
    	echo "Couldn't install OpenCV." >> log.txt
	exit 1
  fi;
echo "OpenCV successfully installed!" >> log.txt

update
change

#NetBeans and Gradle Support
# Installing Netbeans8.2 and Gradle Support. Failure on auto install Gradle Support Plugin
echo "Installing NetBeans 8.2..." >> log.txt
  if ! (cd /tmp && sudo wget -c http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh)
  then
	  echo "Unable to download the Netbeans script." >> log.txt
	  exit 1
  elif ! (chmod 755 netbeans-8.2-linux.sh && sudo ./netbeans-8.2-linux.sh --silent -y)
  then
	  echo "Couldn't install NetBeans." >> log.txt
	  exit 1
  fi;
  echo "Downloading Gradle Support." >> log.txt
  if ! (sudo wget https://github.com/kelemen/netbeans-gradle-project/releases/download/v2.0.2/netbeans-gradle-plugin-2.0.2.nbm)
  then
	  echo "Unable to download the plugin." >> log.txt
	  exit 1
  fi;
echo "Netbeans successfully installed and Gradle Support successfully downloaded!" >> log.txt

update
change

#Blender
#Simple install.
echo "Installing Blender..." >> log.txt
  if ! (sudo apt-get install blender)
  then
	  echo "Unable to download blender." >> log.txt
	  exit 1
  fi;
  update
echo "Blender successfully installed!" >> log.txt

update
change

#Visual Code
#Simple install.
echo "Installing VSCode..." >> log.txt
  if ! (sudo wget https://go.microsoft.com/fwlink/?LinkID=760868 -O visualstudio.deb && sudo dpkg -i visualstudio.deb)
  then
	  echo "Unable to install VSCode." >> log.txt
	  exit 1
  fi;
echo "Visual Code successfully installed!." >> log.txt

update
change

#Eletric
echo "Installing Eletric..." >> log.txt
  mkdir /home/${USERNAME}/Eletric
  cd /home/${USERNAME}/Eletric
  if ! (sudo wget https://ftp.gnu.org/pub/gnu/electric/electricBinary-9.07.jar -O electric.jar)
  then
   	echo "Unable to download Electric Java machine." >> log.txt
	  exit 1
  fi;
  cp electric.jar /usr/share/java/
  unzip electric.jar
  echo "Creating a .desktop file..." >> log.txt
  if ! (echo "[Desktop Entry]" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Type=Application" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Name=Electric" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "GenericName=Electric" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Path=/usr/share/java/" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Exec=java -jar /usr/share/java/electric.jar" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Icon=/home/${USERNAME}/Eletric/ElectricIcon64x64.png" >> /home/${USERNAME}/.local/share/applications/Electric.desktop && echo "Terminal=False" >> /home/${USERNAME}/.local/share/applications/Electric.desktop)
  then
	  echo "Unable to create a .desktop file." >> log.txt
	  exit 1
  fi;
echo "Eletric successfully installed!" >> log.txt

update
change

#PostgreSQL
echo "Installing PostgreSQL..." >> log.txt
  if ! (chmod 755 postgresql-10.6-1-linux-x64.run && sudo ./postgresql-10.6-1-linux-x64.run --unattendedmodeui minimalWithDialogs --superaccount aluno --serviceaccount aluno --superpassword 123456 --mode unattended --prefix /opt/PostgreSQL/10 --datadir /opt/PostgreSQL/10/data)
  then
  	echo "Couldn't install PostgreSQL." >> log.txt
  	exit 1
  fi;
echo "PostgreSQL successfully installed!" >> log.txt

update
change

#IBM ILOG CPLEX
echo "Installing IBM ILOG CPLEX..." >> log.txt
  if ! (chmod 755 cplex_studio128.linux-x86-64.bin && sudo ./cplex*.bin)
  then
	echo "Couldn't install IBM ILOG CPLEX." >> log.txt
	exit 1
  fi;
echo "IBM ILOG CPLEX successfully installed!" >> log.txt

update
change

#XMind
echo "Installing XMind..." >> log.txt
  if ! (sudo apt-get install libwebkitgtk-1.0-0 -y && sudo apt-get install lame -y)
  then
	  echo "Unable to install the requirements." >> log.txt
	  exit 1
  elif ! (sudo dpkg -i xmind-8-beta-linux_amd64.deb -y)
  then
	  echo "Couldn't install  XMind." >> log.txt
    exit 1
  fi;
echo "XMind successfully installed!" >> log.txt

update
change

#SQLDeveloper
echo "Installing SQLDeveloper..." >> log.txt
  if ! (sudo alien --scripts sqldeveloper*.rpm && sudo dpkg -i sqldeveloper*.deb && remover && sudo apt-get remove icedtea-*-plugin)
  then
	echo "Couldn't install SQLDeveloper." >> log.txt
	exit 1
  fi;
  sudo echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /home/${USERNAME}/.sqldeveloper/18.4.0/product.conf
  echo "Configuration successfully completed." >> log.txt
echo "SQLDeveloper successfully installed!" >> log.txt

echo "Step One successfully installed!" >> log.txt
exit(1);

#Step Two

update
change
remove

#Arduino IDE
echo "Installing Arduino IDE..." >> log.txt
  if ! (sudo wget https://downloads.arduino.cc/arduino-1.8.8-linux64.tar.xz && tar xvf arduino-1.8.8-linux64.tar.xz)
  then
    echo "Unable to download the package for Arduino IDE." >> log.txt
    exit 1
  elif ! (cd arduino*/ && sudo sh ./install.sh)
  then
    echo "Couldn't install Arduino IDE." >> log.txt
    exit 1
  fi;
echo "Arduino IDE successfully installed!" >> log.txt

#Arquivos de Eletrônica
echo "Files already present only move them from directory." >> log.txt
  mv /home/${USERNAME}/Downloads/ArquivosEletrotécnica /home/${USERNAME}/
  mv ArquivosEletrotécnica Arquivos\ Eletrotécnica
echo "Files on the right directory." >> log.txt

#Codeblocks
update
echo "Installing CodeBlocks..." >> log.txt
  if ! (sudo apt-get install codeblocks -y)
  then
    echo "Couldn't install CodeBlocks." >> log.txt
    exit 1
  fi;
echo "CodeBlocks successfully installed!" >> log.txt

#Eclipse
update
echo "Installing Eclipse..." >> log.txt
  if ! (sudo apt-get install eclipse -y)
  then
    echo "Couldn't install Eclipse." >> log.txt
    exit 1
  fi;
echo "Eclipse successfully installed!" >> log.txt

#MongoDB
update
echo "Installing MongoDB..." >> log.txt
  if ! (sudo apt-get install mongodb -y && sudo systemctl status mongodb && mongo --eval 'db.runCOmmand({ connectionStatus: 1 })')
  then
    echo "Couldn't install  MongoDB." >> log.txt
    exit 1
  fi;
echo "MongoDB successfully installed!" >> log.txt

#MyOpenLab
change
echo "Installing MyOpenLab..." >> log.txt
  if ! (sudo wget https://myopenlab.org/distribution_linux_3.11.0.zip -y && unzip distribution_linux_3.11.0.zip -d distribution_linux_3.11.0)
  then
    echo "Couldn't install  MongoDB." >> log.txt
    exit 1
  elif ! (cd distribution_linux_3.11.0/ && sudo sh ./start_linux)
  then
    echo "Couldn't install  MongoDB." >> log.txt
    exit 1
  elif ! (sudo update-java-alternatives --set \java-1.8.0-openjdk-$(dpkg --print-architecture))
  then
    echo "Couldn't configurate MongoDB with JDK 8." >> log.txt
    exit 1
  fi;
echo "MyOpenLab successfully installed!" >> log.txt

#NetLogo
update
change
echo "Installing NetLogo..." >> log.txt
  if ! (sudo wget https://ccl.northwestern.edu/netlogo/6.0.4/NetLogo-6.0.4-64.tgz)
  then
    echo "Unable to download the file NetLogo." >> log.txt
    exit 1
  elif ! (tar -xzvf NetLogo-6.0.4-64.tgz -C /home/${USERNAME}/ && cd ~/NetLogo\ 6.0.4/ && wget http://netlogoweb.org/assets/images/desktopicon.png)
  then
    echo "Unable to extract the NetLogo file." >> log.txt
    exit 1
  fi;
  echo "Creating a .desktop file..." >> log.txt
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
echo "NetLogo successfully installed!" >> log.txt

#Pentaho
update
echo "Installing Pentaho..." >> log.txt
    if ! (mkdir Pentaho && cd Pentaho && mkdir 3.1 && mkdir 3.2 && mkdir 3.3 && mkdir 3.4)
    then
      echo "Unable to create files." >> log.txt
      exit 1
    elif ! (cd 3.1 && wget https://sourceforge.net/projects/pentaho/files/Business%20Intelligence%20Server/6.1/biserver-ce-6.1.0.1-196.zip && unzip biserver-ce-6.1.0.1-196.zip && rm biserver-ce-6.1.0.1-196.zip)
		then
      echo "Unable to download Pentaho version 3.1." >> log.txt
      exit 1
    elif ! (cd ~/Downloads/Pentaho/3.2/ && wget https://sourceforge.net/projects/pentaho/files/Report%20Designer/6.1/prd-ce-6.1.0.1-196.zip && unzip prd-ce-6.1.0.1-196.zip && rm prd-ce-6.1.0.1-196.zip)
    then
      echo "Unable to download Pentaho version 3.2." >> log.txt
      exit 1
    elif ! (cd ~/Downloads/Pentaho/3.3/ && wget https://sourceforge.net/projects/mondrian/files/schema%20workbench/3.12.0/psw-ce-3.12.0.1-196.zip && unzip psw-ce-3.12.0.1-196.zip && rm psw-ce-3.12.0.1-196.zip &&)
    then
      echo "Unable to download Pentaho version 3.3." >> log.txt
      exit 1
    elif ! (cd ~/Downloads/Pentaho/3.4 && wget https://sourceforge.net/projects/pentaho/files/Data%20Integration/6.1/pdi-ce-6.1.0.1-196.zip && unzip pdi-ce-6.1.0.1-196.zip && rm pdi-ce-6.1.0.1-196.zip)
    then
      echo "Unable to download Pentaho version 3.4." >> log.txt
      exit 1
    fi;
    change
    mv Pentaho/ /home/${USERNAME}
echo "Pentaho successfully installed!" >> log.txt

#Pinta
update
change
echo "Installing Pinta..." >> log.txt
  if ! (sudo add-apt-repository ppa:pinta-maintainers/pinta-stable && update)
  then
    echo "Unable to install the requirements." >> log.txt
    exit 1
  elif ! (sudo apt-get install pinta -y)
  then
    echo "Unable to install Pinta." >> log.txt
    exit 1
  fi;
echo "Pinta successfully installed!" >> log.txt

#Portugol Studio
update
change
echo "Installing Portugol Studio..." >> log.txt
  if ! (mkdir PortugolStudio && cd ~/Downloads/PortugolStudio/ && wget https://github.com/UNIVALI-LITE/Portugol-Studio/releases/download/v2.7.1/portugol-studio-2.7.1-linux-x64.run.zip && unzip portugol-studio-2.7.1-linux-x64.run.zip && chmod 755 portugol-studio-2.7.1-linux-x64.run)
  then
    echo "Unable to download Portugol Studio file." >> log.txt
    exit 1
  elif ! (sudo ./portugol-studio-2.7.1-linux-x64.run --mode unattended && cd ~/Downloads/ && rm -rf PortugolStudio/)
    echo "Unable to install Portugol Studio." >> log.txt
    exit 1
  fi;
echo "Portugol Studio successfully installed!" >> log.txt

#Project Libre
update
change
echo "Installing Project Libre..." >> log.txt
  if ! (sudo wget https://ufpr.dl.sourceforge.net/project/projectlibre/ProjectLibre/1.8/projectlibre_1.8.0-1.deb -O projectlibre.deb && sudo dpkg -i projectlibre.deb && sudo apt-get install -f)
  then
    echo "Unable to install Project Libre." >> log.txt
    exit 1
  fi;
echo "Project Libre successfully installed!" >> log.txt

#Robo 3T
update
change
echo "Installing Robo 3T..." >> log.txt
  if ! (sudo snap install robo3t-snap)
  then
	echo "Unable to install Robo3T." >> log.txt
	exit 1
  fi;
echo "Robo3T successfully installed!" >> log.txt

update
#RPGBoss
echo "Installing RPGBoss..." >> log.txt
  cd /home/${USERNAME}/
  if ! (sudo wget https://github.com/rpgboss/rpgboss/archive/v0.9.8.tar.gz && tar -xvf v0.9.8.tar.gz && cd rpgboss-0.9.8/ && ./gradlew run)
  then
  	echo "Unable to install RPGBoss." >> log.txt
  	exit 1
  elif ! (mv package/linux/rpgboss.desktop  ~/.local/share/applications/)
  then
  	echo "Preparing a .desktop file." >> log.txt
  	exit 1
  fi;
  echo "Updating the .desktop file." >> log.txt
  echo "[Desktop Entry]
        Name= RPGBoss game editor
        Exec=sh /home/${USERNAME}/rpgboss-0.9.8/package/linux/launch.sh
        Icon=/home/${USERNAME}/rpgboss-0.9.8/package/linux/icon.png
        Terminal=false
        Type=Application" > /home/${USERNAME}/.local/share/applications/rpgboss.desktop
echo "RPGBoss successfully installed!" >> log.txt

#RStudio
update
change
echo "Installing RStudio..." >> log.txt
  if ! (sudo wget https://download1.rstudio.org/rstudio-xenial-1.1.463-amd64.deb && sudo dpkg -i rstudio-xenial-1.1.463-amd64.deb)
  then
    echo "Unable to install RStudio." >> log.txt
    exit 1
  fi;
echo "RStudio successfully installed!" >> log.txt

#Scilab

update
change
echo "Installing Scilab..." >> log.txt
  if ! (mkdir Scilab && cd Scilab)
  then 
	echo "Unable to create a Scilab folder." >> log.txt
	exit 1
  elif ! (wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab_5.5.2-2ubuntu3_all.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-cli_5.5.2-2ubuntu3_all.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-data_5.5.2-2ubuntu3_all.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-doc_5.5.2-2ubuntu3_all.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-full-bin_5.5.2-2ubuntu3_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-include_5.5.2-2ubuntu3_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-minimal-bin_5.5.2-2ubuntu3_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/s/scilab/scilab-test_5.5.2-2ubuntu3_all.deb)
  then
	echo "Unable to download scilab files." >> log.txt
	exit 1
  elif ! (wget http://security.ubuntu.com/ubuntu/pool/universe/h/hdf5/libhdf5-10_1.8.16+docs-4ubuntu1.1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libsuitesparseconfig4.4.6_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libamd2.4.1_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/universe/libm/libmatio/libmatio2_1.5.3-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libcamd2.4.1_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libccolamd2.9.1_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libcolamd2.9.1_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libcholmod3.0.6_4.4.6-1_amd64.deb && wget http://mirrors.kernel.org/ubuntu/pool/main/s/suitesparse/libumfpack5.7.1_4.4.6-1_amd64.deb)
  then
	echo "Unable to download scilab dependencies." >> log.txt
	exit 1
  elif ! (update && sudo apt-get install libcurl3 -y && sudo apt-get install ./lib*.deb -y && sudo apt-get install ./scilab*.deb -y && sudo apt-get install openjdk-8-jre openjdk-8-jre-headless -y)
  then
	echo "Unable to install the downloaded files." >> log.txt
	exit 1
  elif ! (sudo sed -i "s/^Exec=scilab -f$/Exec=env JAVA_HOME=\/usr\/lib\/jvm\/java-8-openjdk-$(dpkg --print-architecture)\/jre scilab -f/" /usr/share/applications/scilab.desktop && sudo sed -i "s/^Exec=scilab-adv-cli$/Exec=env JAVA_HOME=\/usr\/lib\/jvm\/java-8-openjdk-$(dpkg --print-architecture)\/jre scilab-adv-cli/" /usr/share/applications/scilab-adv-cli.desktop)
  then
	echo "Unable to install scilab." >> log.txt
	exit 1
  fi;
echo "Scilab successfully installed!" >> log.txt

#VirtualBox
update
change
echo "Installing VirtualBox..." >> log.txt
  if ! (sudo add-apt-repository multiverse && update)
  then
    echo "Unable to install the requirements." >> log.txt
    exit 1
  elif ! (sudo apt-get install virtualbox -y)
    echo "Unable to install VirtualBox." >> log.txt
    exit 1
  fi;
echo "VirtualBox successfully installed!" >> log.txt

#VLC
update
change
echo "Installing VLC..." >> log.txt
  if ! (sudo add-apt-repository ppa:videolan/master-daily)
  then
    echo "Unable to get the repository." >> log.txt
    exit 1
  elif ! (sudo apt-get install vlc -y)
  then
    echo "Unable to install VLC." >> log.txt
    exit 1
  fi;
echo "VLC successfully installed!" >> log.txt

#Wireshark
update
change
echo "Installing Wireshark..." >> log.txt
  if ! (sudo add-apt-repository ppa:wireshark-dev/stable && update)
  then
    echo "Unable to get the repository." >> log.txt
    exit 1
  elif ! (sudo apt-get install wireshark -y)
    echo "Unable to install Wireshark." >> log.txt
  fi;
echo "Wireshark successfully installed!" >> log.txt

#XAMP
update
change
echo "Installing XAMPP..." >> log.txt
  if ! (sudo wget https://www.apachefriends.org/xampp-files/7.3.1/xampp-linux-x64-7.3.1-0-installer.run && sudo chmod 755 xampp-linux-x64-7.3.1-0-installer.run && sudo ./xampp-linux-x64-7.3.1-0-installer.run --mode unattended --disable-components xampp_developer_files && sudo apt-get install net-tools -y)
  then
    echo "Unable to install XAMPP." >> log.txt
    exit 1
  fi;
echo "XAMPP successfully installed!" >> log.txt

update
change
#Cisco Packet Tracer
#Error on silent install: Enter Space Y Enter Enter Enter
echo "Installing Cisco Packet Tracer..." >> log.txt
  if ! (mkdir CiscoPacketTracer && cd CiscoPacketTracer/  && sudo tar -xzvf Packet*.tar.gz)
  then
  	echo "Unable to tar Cisco Packet Tracer." >> log.txt
  	exit 1
  elif ! (sudo ./install ) #Need quiet install
  then
  	echo "Unable to install Cisco Packet Tracer." >> log.txt
  	exit 1
  elif ! (cd /opt/bin/pt && ldd PacketTracer7 | grep "not found")
  then
  	echo "Not missing files or links." >> log.txt
  elif ! (sudo sh -c "echo 'deb http://security.ubuntu.com/ubuntu xenial-security main ' >> /etc/apt/sources.list" && update && sudo apt-get install libpng12-0 -y && sudo apt-get install libpng12-dev -y)
  then
  	echo "Solved the problem." >> log.txt
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
echo "Cisco Packett Tracer successfully installed!" >> log.txt
update

echo "Step One successfully installed!" >> log.txt
exit(1);