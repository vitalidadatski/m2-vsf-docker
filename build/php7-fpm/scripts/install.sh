#!/bin/sh
set -e
echo "Pre-install scripts running"
for f in /docker/scripts/pre-*.sh; do
  chmod a+x "$f"
  sh "$f" || break  # execute successfully or break
done

echo "Clean Magento dirs"
rm -rf ${MAGENTO_ROOT}/generated/*
rm -rf ${MAGENTO_ROOT}/pub/static/*
rm -rf ${MAGENTO_ROOT}/var/cache/*
rm -rf ${MAGENTO_ROOT}/app/etc/config.php
rm -rf ${MAGENTO_ROOT}/app/etc/env.php

echo "Run Magento installation"
php ${MAGENTO_ROOT}/bin/magento setup:install --admin-user=$MAGENTO_ADMIN_USERNAME --admin-password=$MAGENTO_ADMIN_PASSWORD \
    --admin-email=$MAGENTO_ADMIN_EMAIL --admin-firstname=$MAGENTO_ADMIN_FIRSTNAME \
    --admin-lastname=$MAGENTO_ADMIN_LASTNAME --db-host=mysql --db-user=$MYSQL_USER \
    --db-name=$MYSQL_DATABASE --db-password=$MYSQL_PASSWORD --base-url=$APPLICATION_PROTOCOL$APPLICATION_DOMAIN"/" \
    --backend-frontname=admin \
    --cleanup-database --magento-init-params="MAGE_MODE=${MAGENTO_MODE}"

echo "Post-install scripts running"
for f in /docker/scripts/post-*.sh; do
  chmod a+x "$f"
  sh "$f" || break  # execute successfully or break
done

exec "$@"