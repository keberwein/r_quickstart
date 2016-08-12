#!/bin/bash
echo ""
echo "Updating Ubuntu system software"
echo "###################################################"
echo ""
sudo apt-get -yy update && sudo apt-get -yy upgrade
echo ""
echo "Installing dependencies. This may take a minute!"
echo "###################################################"
echo ""
sudo apt-get -yy install openssh-client openssh-server git
sudo apt-get -yy install libssl-dev libcurl4-openssl-dev
sudo apt-get -yy install libxml2-dev libzmq3-dev libpq-dev
sudo apt-get -yy install ubuntu-dev-tools libapparmor1 psmisc 
sudo apt-get -yy install -y gdebi-core
echo ""
echo ""
echo "Installing R and Rstudio-Server"
echo "###################################################"

echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update
sudo apt-get -yy install r-base r-base-dev
sudo sed -i 's@R_LIBS_USER@#R_LIBS_USER@' /usr/lib/R/etc/Renviron
sudo sed -i 's@##R_LIBS_USER@R_LIBS_USER@' /usr/lib/R/etc/Renviron
sudo chmod 777 /usr/lib/R/site-library
sudo chmod 777 /usr/local/lib/R/site-library

echo ""
echo ""
echo "Downloading, installing, and configuring shiny-server"
echo "###################################################"
echo ""
sudo apt-get -yy install openjdk-7-jdk
export LD_LIBRARY_PATH=/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server
sudo R CMD javareconf  
sudo su - -c "R -e \"install.packages(c('shiny', 'rmarkdown', 'devtools'), repos='http://cran.rstudio.com/')\""
sudo wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.4.801-amd64.deb
sudo gdebi shiny-server-1.4.4.801-amd64.deb
echo ""
echo ""
echo "Setting permissions for Shiny"
echo "###################################################"
echo ""
sudo chmod -R 777 /srv/shiny-server
echo ""
echo ""
echo "You R / Shiny Machine is tuned up and ready to run!"
echo "Shiny Server is running on port 3838"
echo "###################################################"
exit


