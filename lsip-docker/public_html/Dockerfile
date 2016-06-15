FROM mysql
MAINTAINER Matthieu PENICAUD <matthieu.penicaud@inserm.fr>
#VOLUME ["/var/lib/mysql"]
RUN mkdir /var/data/
RUN mkdir /var/data/LSIP/
RUN mkdir /var/data/LSIP/db/
RUN chmod 777 -R /var/
RUN chmod 644 /etc/mysql/my.cnf
ADD ./files/LSIP_schema.sql ./files/init_db ./files/start_services /var/data/LSIP/

RUN /var/data/LSIP/init_db
#EXPOSE 3306

ENV DEBIAN_FRONTEND=noninteractive

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www

RUN apt-get update
RUN apt-get install -y apache2 php5 libapache2-mod-php5 php5-mysql php-apc git

RUN git clone  https://github.com/Biobanques/lsip.git /var/www/SIP

VOLUME [ "/var/log/apache2", "/etc/apache2"]

ADD ./files/lsip.conf /etc/apache2/sites-available/000-default.conf
ADD ./files/CommonProperties.php /var/www/SIP/CommonProperties.php
RUN mkdir  /var/www/SIP/protected/data/import/
RUN chmod 777 -R /var/www/SIP/protected/runtime /var/www/SIP/assets/ /var/www/SIP/protected/data/import/
EXPOSE 80 443 
ENTRYPOINT "/var/data/LSIP/start_services"

