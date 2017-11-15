mkdir /root/_tem
cd /root/_tem

yum update -y
yum upgrade -y

useradd xxx
passwd xxx

yum install curl wget nano vim  -y

yum install openssh openssh-server openssh-clients openssl-libs


# nano /etc/ssh/sshd_config
#AllowUsers xxx
#PermitRootLogin no
systemctl enable sshd
systemctl restart sshd.service


yum install firewalld
systemctl enable firewalld
yum install fail2ban -y
yum install rkhunter -y

yum groupinstall "Development tools" -y
yum install kernel-headers kernel-devel -y
yum install autoconf libcurl-devel expat-devel gcc gettext-devel kernel-headers openssl-devel perl-devel zlib-devel -y

# git package (usually older version)
yum install git
# git latest manually build (see github for the latest - as of now is 2.15 - and remember to override git command with source/export local paths)
#wget https://github.com/git/git/archive/v2.15.0.tar.gz
#tar -zxvf v2.15.0.tar.gz
#cd git-2.15.0
#make clean
#make configure
#./configure --prefix=/usr/local
#make
#make install
#cd ../
#rm -rf git-2.15.0/
#rm -f v2.15.0.tar.gz


#php
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

yum install php71w-common php71w-cli php71w-phpdbg php71w-bcmath php71w-devel php71w-gd php71w-imap php71w-mbstring php71w-mcrypt php71w-mysqlnd php71w-intl
yum install php71w-pdo php71w-pear php71w-pecl-memcached php71w-pecl-mongodb php71w-pecl-redis php71w-pecl-xdebug php71w-process php71w-soap php71w-tidy php71w-xml php71w-xmlrpc

#composer global require phpunit/phpunit
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
cp phpunit.phar /usr/local/bin/phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit

#composer global require pdepend/pdepend
wget http://static.pdepend.org/php/latest/pdepend.phar
chmod +x pdepend.phar
cp pdepend.phar /usr/local/bin/pdepend.phar
mv pdepend.phar /usr/local/bin/pdepend

#composer global require phpmd/phpmd
wget -c http://static.phpmd.org/php/latest/phpmd.phar
chmod +x phpmd.phar
cp phpmd.phar /usr/local/bin/phpmd.phar
mv phpmd.phar /usr/local/bin/phpmd

#composer global require phploc/phploc
wget https://phar.phpunit.de/phploc.phar
chmod +x phploc.phar
cp phploc.phar /usr/local/bin/phploc.phar
mv phploc.phar /usr/local/bin/phploc

#composer global require --dev sebastian/phpcpd
wget https://phar.phpunit.de/phpcpd.phar
chmod +x phpcpd.phar
cp phpcpd.phar /usr/local/bin/phpcpd.phar
mv phpcpd.phar /usr/local/bin/phpcpd

#composer global require "squizlabs/php_codesniffer=*"
pear install PHP_CodeSniffer

#phpdoc from pear
pear channel-discover pear.phpdoc.org
pear install phpdoc/phpDocumentor

#phpdox
wget http://phpdox.de/releases/phpdox.phar
chmod +x phpdox.phar
cp phpdox.phar /usr/local/bin/phpdox.phar
mv phpdox.phar /usr/local/bin/phpdox


#java 8
cd /opt/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz"
tar xzf jdk-8u152-linux-x64.tar.gz
cd jdk1.8.0_152/
alternatives --install /usr/bin/java java /opt/jdk1.8.0_152/bin/java 2

alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_152/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_152/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_152/bin/jar
alternatives --set javac /opt/jdk1.8.0_152/bin/javac

export JAVA_HOME=/opt/jdk1.8.0_152
export JRE_HOME=/opt/jdk1.8.0_152/jre
export PATH=$PATH:/opt/jdk1.8.0_152/bin:/opt/jdk1.8.0_152/jre/bin

#jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins
chkconfig jenkins on
systemctl restart jenkins.service

firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload

yum install ant -y


# -- rkhunter common taks
rkhunter --versioncheck;
rkhunter --update --propupd;
rkhunter --checkall;
#todo maldet
#todo chkrootkit
#todo htop
#todo mysql