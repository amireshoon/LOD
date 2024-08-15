# LOD
Laravel Octane Dockerfile

## Requirements
- Docker :)

# What this Dockefile does?
- Pulls official php8.2 image
- Installs git \ curl \ libpng-dev \ libonig-dev \ libxml2-dev \ zip \ unzip \ libzip-dev \ libssl-dev \ pkg-config \ libcurl4-openssl-dev \ zlib1g-dev \ libgmp-dev \ libmcrypt-dev \ libicu-dev \ g++ \ make \ autoconf \ libbrotli-dev \ nodejs \ npm
- Installs and enables These PHP extensions: pdo_mysql, mbstring, exif, pcntl, bcmath, gd, intl, gmp
- Installs and enables Swoole
- Installs chokidar-cli npm package for laravel octane file change option
- Installs composer(latest version)
- Sets up correct permissions
- Exposes 8000 port
