#!/bin/sh
set -e

echo "Setup AMQP"
php ${MAGENTO_ROOT}/bin/magento setup:config:set --amqp-host=rabbit --amqp-user=magento --amqp-password=magento

exec "$@"