# R quick upstart script for CentOS 7

sudo yum update

sudo yum install wget -y

# Get the EPEL rpm
sudo yum install epel-release
sudo yum update

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

# Install Postgres. This is so the RPostgreSQL package will work properly. The database needs not be configured.
sudo yum install postgresql-devel -y
# Plotly needs libcurl
sudo yum install libcurl-devel -y

sudo su - -c "R -e \"install.packages(c('shiny', 'rmarkdown', 'devtools', 'RJDBC', 'dplyr', 'plotly', 'RPostgreSQL', 'lubridate', 'DT'), repos='http://cran.rstudio.com/')\""

# Download Shiny Server
wget https://download3.rstudio.org/centos5.9/x86_64/shiny-server-1.5.3.838-rh5-x86_64.rpm
sudo yum install --nogpgcheck shiny-server-1.5.3.838-rh5-x86_64.rpm -y

# Create a root directory for shiny website
sudo mkdir -p /var/shiny-server/www

# Create a directory for application logs
sudo mkdir -p /var/shiny-server/log

# Start Shiny
sudo start shiny-server

# Edit firewall rules CentOS 6
sudo firewall-cmd --zone=public --add-port=3838/tcp --permanent
firewall-cmd --reload

################# Rstudio Server setup

wget https://download2.rstudio.org/rstudio-server-rhel-1.0.143-x86_64.rpm
sudo yum install --nogpgcheck rstudio-server-rhel-1.0.143-x86_64.rpm -y

# Edit firewall rules CentOS 6
sudo firewall-cmd --zone=public --add-port=8787/tcp --permanent
firewall-cmd --reload
