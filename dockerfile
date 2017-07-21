FROM ubuntu:16.04

MAINTAINER William Torres <wiltorc2430@gmail.com>

RUN apt-get update

# Instalacion ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/ssh

# Set password to 'admin'
RUN printf admin\\nadmin\\n | passwd

# Install php
RUN apt-get install -y php &&	apt-get install -y libapache2-mod-php7.0 \
&& apt-get install -y php7.0-mcrypt
#	php-pgsql \
#	libapache2-mod-auth-pgsql \
#	php7.0-curl \
#	php-mbstring \
#	php7.0-mbstring \
#	php-gettext \
#	libapache2-mod-php7.0 \
#	php7.0-gd php-zip \
#	apache2 \

# Install Apache
#RUN apt-get install -y apache2

# Install postgresql
RUN apt-get install -y postgresql

# Install phppgadmin
RUN apt-get install -y phppgadmin

EXPOSE 22
EXPOSE 80
EXPOSE 5432
