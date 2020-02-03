
 #!/bin/sh
set -e
if [ ! -f $MAGENTO_ROOT/var/elastic_configured ];
then
  echo "Set Catalog Search to ElasticSearch"
  php ${MAGENTO_ROOT}/bin/magento config:set catalog/search/engine elasticsearch5
  php ${MAGENTO_ROOT}/bin/magento config:set catalog/search/elasticsearch5_server_hostname elasticsearch
  php ${MAGENTO_ROOT}/bin/magento config:set catalog/search/elasticsearch5_server_port 9200
  php ${MAGENTO_ROOT}/bin/magento config:set catalog/search/elasticsearch5_index_prefix magento2

  echo "Set VSF ElasticSearch Configs"
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/general_settings/enable 1
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/general_settings/allowed_stores 1
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/indices_settings/index_name vue_storefront_catalog
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/es_client/host elasticsearch
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/es_client/port 9200
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/indices_settings/batch_indexing_size 1000
  php ${MAGENTO_ROOT}/bin/magento config:set vsbridge_indexer_settings/indices_settings/index_identifier id
  touch $MAGENTO_ROOT/var/elastic_configured && chmod ugo+rw $MAGENTO_ROOT/var/elastic_configured
  echo "Start Reindex"
  php ${MAGENTO_ROOT}/bin/magento indexer:reindex
else
	echo "It seems like elastic search already configured. If you want reconfigure elastic search, remove $MAGENTO_ROOT/var/elastic_configured"
fi

exec "$@"