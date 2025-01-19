#!/bin/bash

export COMPOSER_NO_INTERACTION=1
rm -rf composer.lock
yes | composer install -n
npm install
php artisan migrate
php artisan key:generate
