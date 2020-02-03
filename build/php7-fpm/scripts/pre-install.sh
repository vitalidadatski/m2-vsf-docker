#!/bin/sh
set -e

echo "Permissions have been set"
chmod_app="$MAGENTO_ROOT/app/etc $MAGENTO_ROOT/var $MAGENTO_ROOT/generated $MAGENTO_ROOT/vendor"
chmod_static="$MAGENTO_ROOT/pub/static $MAGENTO_ROOT/pub/media"
find $chmod_app $chmod_static -type f -exec chmod g+w {} \;
find $chmod_app $chmod_static -type d -exec chmod g+sw {} \;
chmod g+x $MAGENTO_ROOT/bin/magento

exec "$@"