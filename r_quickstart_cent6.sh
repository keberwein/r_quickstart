sudo yum update

sudo yum install wget -y

# Get the EPEL rpm
wget http://mirror.us.leaseweb.net/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm

# Import the EPEL GPG key
wget https://www.fedoraproject.org/static/0608B895.txt
sudo mv 0608B895.txt /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

# Verify that the key has been imported.
rpm -qa gpg*

# Install the rpm
sudo rpm -ivh epel-release-6-8.noarch.rpm

sudo yum install npm -y

sudo yum install R-core R-devel -y

sudo su - -c "R -e \"install.packages(c('shiny', 'rmarkdown', 'devtools', 'RJDBC', 'dplyr', 'tidyr', 'knitr', 'plotly', 'devtools', 'RPostgreSQL', 'lubridate', 'DBI', 'reshape2', 'DT', 'htmlwidgets'), repos='http://cran.rstudio.com/')\""

# Install Postgres. This is so the RPostgreSQL package will work properly. The database needs not be configured.
sudo yum install postgresql postgresql-contrib -y

# Download Shiny Server
wget https://download3.rstudio.org/centos5.9/x86_64/shiny-server-1.5.1.834-rh5-x86_64.rpm
sudo yum install --nogpgcheck shiny-server-1.5.1.834-rh5-x86_64.rpm -y

# Install Upstart script
sudo wget https://raw.github.com/rstudio/shiny-server/master/config/upstart/shiny-server.conf -O /etc/init/shiny-server.conf

# Create a root directory for shiny website
sudo mkdir -p /var/shiny-server/www

# Create a directory for application logs
sudo mkdir -p /var/shiny-server/log

# Start Shiny
sudo start shiny-server

# Edit firewall rules CentOS 6
sudo iptables -I INPUT -p tcp -m tcp --dport 3838 -j ACCEPT
sudo service iptables save

################# Rstudio Server setup

wget https://download2.rstudio.org/rstudio-server-rhel-1.0.136-x86_64.rpm
sudo yum install --nogpgcheck rstudio-server-rhel-1.0.136-x86_64.rpm -y

# Edit firewall rules CentOS 6
sudo iptables -I INPUT -p tcp -m tcp --dport 8787 -j ACCEPT
sudo service iptables save

# Add group and users for RStudio Server

groupadd rstudio_users
usermod -a -G rstudio_users keberwein
chown -R keberwein:rstudio_users /home/keberwein