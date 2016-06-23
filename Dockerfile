FROM ubuntu:16.04

MAINTAINER Johannes Steu hello@johannessteu.de

RUN apt-get update
RUN apt-get install -y wget openssl php git ssh curl unzip sudo npm nodejs build-essential libssl-dev

RUN curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh
RUN bash install_nvm.sh

RUN wget --no-check-certificate https://getcomposer.org/installer && mv installer composer-setup.php
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'bf16ac69bd8b807bc6e4499b28968ee87456e29a3894767b60c2d4dafa3d10d045ffef2aeb2e78827fa5f024fbe93ca2') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/bin/composer
RUN composer self-update

RUN npm install --global gulp-cli