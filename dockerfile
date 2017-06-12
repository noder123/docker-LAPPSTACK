FROM ubuntu:16.04

MAINTAINER William Torres <wiltorc2430@gmail.com>

RUN apt-get update

# Install ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/ssh

# Set password to 'admin'
#RUN printf admin\\nadmin\\n | passwd

# Install postgresql
RUN apt-get install -y postgresql
#su - postgres -c "psql -U postgres -d postgres -c \"alter user postgres with password 'postgres';\""

#RUN apt-get install -y postgresql-contrib;

# Set postgresql default encoding to UTF-8
# RUN echo "UPDATE pg_database SET datistemplate=FALSE WHERE datname='template1';" > utf8.sql; \
#	echo "DROP DATABASE template1;" >> utf8.sql; \
#	echo "CREATE DATABASE template1 WITH owner=postgres template=template0 encoding='UTF8';" >> utf8.sql; \
#	echo "UPDATE pg_database SET datistemplate=TRUE WHERE datname='template1';" >> utf8.sql

#RUN service postgresql start; \
#	export PGPASSWORD=root; \

# Install Apache
RUN apt-get install -y apache2
# Install php
RUN apt-get install -y \
	php \
	libapache2-mod-php7.0 \
	php7.0-mcrypt \
	php-pgsql \
	libapache2-mod-auth-pgsql \
	php7.0-curl \
	php-mbstring \
	php7.0-mbstring \
	php-gettext \
	libapache2-mod-php7.0 \
	php7.0-gd php-zip \

# Install phppgadmin
RUN apt-get install -y phppgadmin
RUN sed -i "s/# allow from all/allow from all/g" /etc/apache2/conf.d/phppgadmin
RUN sed -i "s/\$conf\['extra_login_security'\] = true;/\$conf\['extra_login_security'\] = false;/g" /etc/phppgadmin/config.inc.php

EXPOSE 22
EXPOSE 80
EXPOSE 5432

CMD service postgresql start; \
    service postgresql restart; \
	service apache2 start; \
	service apache2 restart; \
	/usr/sbin/sshd -D
