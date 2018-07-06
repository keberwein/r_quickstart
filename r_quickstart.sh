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
echo "Installing R
echo "###################################################"

echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update
sudo apt-get -yy install r-base r-base-dev
sudo sed -i 's@R_LIBS_USER@#R_LIBS_USER@' /usr/lib/R/etc/Renviron
sudo sed -i 's@##R_LIBS_USER@R_LIBS_USER@' /usr/lib/R/etc/Renviron
sudo chmod -R 777 /usr/lib/R/site-library
sudo chmod -R 777 /usr/local/lib/R/site-library


