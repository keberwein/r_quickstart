"R Quickstart"
============

This is a shell script that is designed as a quick way to install the R programming language
and Shiny Server as well as associated dependencies.

Installation
============

Download or copy the shell script and run it on your Ubuntu box under your home user:

	 sh ./r_quickstart.sh

WARNING: Don't execute as root, it needs your home directory for a couple things.

After the install finishes, you're Shiny Serve will be running on default port 3838.

Packages Installed
============
This environment is built for a fresh install of Ubuntu 14.04. It will update/upgrade all base packages and
install all needed dependencies. Software packages installed include:
 - R-core
 - Shiny Server 
 - openssh-client
 - openssh-server 
 - git
 - libssl-dev 
 - libcurl4-openssl-dev
 - libxml2-dev 
 - libzmq3-dev l
 - ibpq-dev
 - ubuntu-dev-tools 
 - libapparmor1 
 - psmisc 
 - gdebi-core
 - nginx
 - apache2-utils
 - openjdk-7-jdk

Changes in default behaviors
============

A few paths and permissions have been modified to make Shiny easier to use:
 - Renviron file has been changed to use a universal library to install R packages that is available to Shiny.
 - chmod 777 /usr/lib/R/site-library so Shiny can access it.
 - chmod 777 /usr/local/lib/R/site-library.
 - chmod -R 777 /srv/shiny-server so the server can find your apps.
 - "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" added to /etc/apt/sources.list
 










