
 #!/bin/sh
set -e

echo "Set Catalog Search to ElasticSearch"
php ${MAGENTO_ROOT}/bin/magento config:set catalog/search/engine elasticsearch6
php ${MAGENTO_ROOT}/bin/magento config:set catalog/search/elasticsearch6_server_hostname elasticsearch
php ${MAGENTO_ROOT}/bin/magento config:set catalog/search/elasticsearch6_server_port 9200
php ${MAGENTO_ROOT}/bin/magento config:set catalog/search/elasticsearch6_index_prefix magento2

echo "Start Reindex"
php ${MAGENTO_ROOT}/bin/magento indexer:reindex

exec "$@"