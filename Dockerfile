FROM docker:dind

MAINTAINER Johannes Steu hello@johannessteu.de

RUN apk add --no-cache nodejs wget openssl php5-cli php5-json php5-phar php5-openssl php5-curl git

RUN wget --no-check-certificate https://getcomposer.org/installer && mv installer composer-setup.php
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === 'bf16ac69bd8b807bc6e4499b28968ee87456e29a3894767b60c2d4dafa3d10d045ffef2aeb2e78827fa5f024fbe93ca2') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/bin/composer