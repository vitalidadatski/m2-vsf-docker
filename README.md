Docker Devbox for Magento 2

# Software stack
- Nginx (stable)
- php-fpm (7.2)
- MySql (percona 5.7)
- ElasticSearch (6.*)
- Redis (5.*)
- Varnish (4.*)

# Usage
- Install docker and docker compose using [official guidelines](https://docs.docker.com/install/)
- Create `.env` file.  All available variables see below

# Stateless Magento build (demo build)
- Create docker volume `docker volume create --name=magento2-root`
- Execute `docker-compose up --build` cli command from repository root. For initial start use an env variable `PERFORM_INSTALLATION=1 docker-compose up --build`


# Stateful Magento build (devbox)
- Install `docker-sync` using [official docs](https://docker-sync.readthedocs.io/en/latest/getting-started/installation.html)
- Configure `docker-sync.yaml` file
- Start file sync by cli command `docker-sync start -f` from repository root. (For Magento Open Source 2.3.3 codebase time to sync took 6 minutes)
- Execute `docker-compose up --build` cli command from repository root. Don't use with `PERFORM_INSTALLATION` env variable. All Magento code will be deleted

# Playing with Magento CLI
- Deploy Magento Sample Data:
- - `docker exec -it project_php7-fpm_1 bin/magento sampledata:deploy` (Composer auth keys required)
- - `docker exec -it project_php7-fpm_1 bin/magento setup:upgrade`
- - `docker exec -it project_php7-fpm_1 bin/magento indexer:reindex`
- - `docker exec -it project_php7-fpm_1 bin/magento c:f config full_page`

- Full Magento reinstall (DB will be cleaned):
- - `docker exec -it project_php7-fpm_1 rm -rf ./var/installed`
- - `docker exec -it project_php7-fpm_1 /docker/scripts/install.sh`

# List of ENV variables
| VARIABLE | IS_REQUIRED | DEFAULT_VALUE |
| --- | --- | --- |
| COMPOSER_MAGENTO_USERNAME | yes | n/a |
| COMPOSER_MAGENTO_PASSWORD | yes | n/a |
| COMPOSER_VAIMO_USERNAME | yes | n/a |
| COMPOSER_VAIMO_PASSWORD | yes | n/a |
| VAIMO_API_USERNAME | yes | n/a |
| VAIMO_API_PASSWORD | yes | n/a |
| MAGENTO_HOST | no | magento2.loc |
| MAGENTO_ROOT | no | /var/www/magento2 |
| MAGENTO_MODE | no | developer |
| MAGENTO_ADMIN_USERNAME | no | admin |
| MAGENTO_ADMIN_PASSWORD | no | adminqwe123 |
| MAGENTO_ADMIN_EMAIL | no | user@example.com |
| MAGENTO_ADMIN_FIRSTNAME | no | Magento |
| MAGENTO_ADMIN_LASTNAME | no | User |
| MAGE_COMPOSER_STABILITY | no | stable |
| MYSQL_DATABASE | no | magento2 |
| MYSQL_USER | no | dbuser |
| MYSQL_PASSWORD | no | admin |
| MYSQL_ROOT_PASSWORD | no | root |

Magento will be deployed on `magento2.loc` hostname, so you need to have it in your host's `/etc/hosts` file. Admin panel will be located on `http://magento2.loc/admin` URL. Login: `admin`, password: `adminqwe123`