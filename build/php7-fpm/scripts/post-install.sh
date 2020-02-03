#!/bin/sh
set -e

chown -R www-data:www-data $MAGENTO_ROOT
chmod_app="$MAGENTO_ROOT/app/etc $MAGENTO_ROOT/var $MAGENTO_ROOT/generated $MAGENTO_ROOT/vendor"
chmod_static="$MAGENTO_ROOT/pub/static $MAGENTO_ROOT/pub/media"
find $chmod_app $chmod_static -type f -exec chmod g+w {} \;
find $chmod_app $chmod_static -type d -exec chmod g+sw {} \;
chmod g+x $MAGENTO_ROOT/bin/magento
echo "Permissions have been set"

echo "Cache flush"
php ${MAGENTO_ROOT}/bin/magento cache:flush

if [ ! -f $MAGENTO_ROOT/var/admin_session_lifetime ];
then
  echo "Set Admin Session Lifetime"
  php ${MAGENTO_ROOT}/bin/magento config:set admin/security/session_lifetime 31536000
  touch $MAGENTO_ROOT/var/admin_session_lifetime && chmod ugo+rw $MAGENTO_ROOT/var/admin_session_lifetime
fi
exec "$@"
