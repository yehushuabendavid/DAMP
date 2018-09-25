FROM ubuntu
ARG PASSWORD=root
RUN apt update
RUN apt-get -y  install apt-utils vim nano net-tools  debconf-utils 
RUN export DEBIAN_FRONTEND=noninteractive ; apt-get -y install mysql-server ;
RUN /etc/init.d/mysql start ; mysql -uroot -e"UPDATE mysql.user SET plugin = 'mysql_native_password', authentication_string = PASSWORD('$PASSWORD') WHERE user = 'root'"
RUN export DEBIAN_FRONTEND=noninteractive ; apt-get -y install  php apache2 phpmyadmin
RUN echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections ;\
dpkg-reconfigure -f nointeractive phpmyadmin
RUN apt-get -y install memcached ssh ;\
echo "PermitRootLogin YES" >> /etc/ssh/sshd_config ;\
echo "root:$PASSWORD" | chpasswd
RUN echo "#!/bin/bash" > startAll.sh ;\
echo "/etc/init.d/mysql restart" >> startAll.sh;\
echo "/etc/init.d/memcached restart" >> startAll.sh;\
echo "/etc/init.d/apache2 restart" >> startAll.sh;\
echo "/etc/init.d/ssh restart" >> startAll.sh;\
echo "bash" >> startAll.sh;\
chmod +x startAll.sh


