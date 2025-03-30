FROM wordpress:6.7.2-php8.1-apache

RUN set -ex; \
    apt-get update && apt-get install -y \
        wget \
        unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# プラグイン関連の作業ディレクトリ変更
WORKDIR /usr/src/wordpress/wp-content/plugins

RUN set -ex; \
    wget -q -O amazon-s3-and-cloudfront.zip https://downloads.wordpress.org/plugin/amazon-s3-and-cloudfront.3.2.11.zip \
    && unzip -q -o '*.zip' -d /usr/src/wordpress/wp-content/plugins \
    && chown -R www-data:www-data /usr/src/wordpress/wp-content/plugins \
    && rm -f '*.zip'

RUN chown -R www-data:www-data /var/www/html

# 作業ディレクトリをデフォルトに変更
WORKDIR /var/www/html