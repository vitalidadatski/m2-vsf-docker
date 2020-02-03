#!/bin/sh
set -e
if [ ! -f $MAGENTO_ROOT/var/redis_configured ];
then
	echo "Setup Redis Default cache"
  php ${MAGENTO_ROOT}/bin/magento setup:config:set --cache-backend=redis --cache-backend-redis-server=redis --cache-backend-redis-db=0
  echo "Setup Redis Page cache"
  php ${MAGENTO_ROOT}/bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=redis --page-cache-redis-db=1 --page-cache-redis-compress-data=1
  echo "Setup Redis Session save"
  php ${MAGENTO_ROOT}/bin/magento setup:config:set --session-save=redis --session-save-redis-host=redis --session-save-redis-log-level=3 --session-save-redis-db=2

  echo "Set VSF Redis Configs"
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/redis_cache_settings/clear_cache 1
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/redis_cache_settings/vsf_base_url http://redis:3000/
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/redis_cache_settings/invalidate_cache_key aeSu7aip
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/redis_cache_settings/connection_timeout 10

  touch $MAGENTO_ROOT/var/redis_configured && chmod ugo+rw $MAGENTO_ROOT/var/redis_configured
else
	echo "It seems like redis already configured. If you want reconfigure redis, remove $MAGENTO_ROOT/var/redis_configured"
fi

exec "$@"