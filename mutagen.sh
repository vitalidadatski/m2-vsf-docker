#!/bin/bash
mutagen create \
       --name=web-app \
       --sync-mode=two-way-resolved \
       --default-file-mode=0644 \
       --default-directory-mode=0755 \
       --ignore=/.idea \
       --ignore=/.magento \
       --ignore=/.docker \
       --ignore=/.github \
       --ignore-vcs \
       --symlink-mode=posix-raw \
       ./src/magento docker://$(docker-compose ps -q php7-fpm|awk '{print $1}')/var/www/magento2
