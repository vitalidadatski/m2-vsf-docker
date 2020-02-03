#!/bin/sh
set -e

echo "Set Caching Application to Varnish"
php ${MAGENTO_ROOT}/bin/magento config:set --scope=default --scope-code=0 system/full_page_cache/caching_application 2

exec "$@"