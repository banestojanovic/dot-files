#!/bin/bash
DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

echo "🚀 Setting up PHP formatting (WordPress + Pint)..."

# 1. Make sure Composer is installed (silent if already there)
if ! command -v composer &> /dev/null; then
    echo "   Installing Composer..."
    EXPECTED_CHECKSUM="$(curl -s https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
    if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
        >&2 echo 'ERROR: Invalid installer checksum'
        rm composer-setup.php
        exit 1
    fi
    php composer-setup.php --quiet
    rm composer-setup.php
    sudo mv composer.phar /usr/local/bin/composer
fi

# 2. Remove any conflicting Homebrew PHPCS (we want only Composer version)
echo "   Removing Homebrew php-code-sniffer if present (prevents conflicts)..."
brew uninstall --force php-code-sniffer 2>/dev/null || true
sudo rm -f /opt/homebrew/bin/phpcs /opt/homebrew/bin/phpcbf 2>/dev/null || true
sudo rm -f /usr/local/bin/phpcs /usr/local/bin/phpcbf 2>/dev/null || true

# 3. Install the perfect WordPress + Pint stack globally via Composer
echo "   Installing squizlabs/php_codesniffer, wp-coding-standards/wpcs, phpcsstandards/phpcsextra and pint..."
composer global require \
    squizlabs/php_codesniffer:^3.10 \
    wp-coding-standards/wpcs:^3 \
    phpcsstandards/phpcsextra:^1.2 \
    dealerdirect/phpcodesniffer-composer-installer \
    laravel/pint --quiet

# 4. Make sure Composer's bin dir is in PATH for this session and future ones
COMPOSER_BIN="$HOME/.composer/vendor/bin"
if [[ ":$PATH:" != *":$COMPOSER_BIN:"* ]]; then
    echo "   Adding Composer bin to PATH..."
    echo "export PATH=\"$COMPOSER_BIN:\$PATH\"" >> ~/.zshrc
    export PATH="$COMPOSER_BIN:$PATH"
fi

# 5. Warm up WordPress sniffs once so first format in Neovim is instant
echo "   Warming up WordPress Coding Standards (takes ~10 seconds first time)..."
echo "<?php echo 'test';" | phpcbf --standard=WordPress - > /dev/null 2>&1 || true

# 6. Install Pint globally if you want it available everywhere (optional but nice)
if [ ! -f "$COMPOSER_BIN/pint" ]; then
    echo "   Installing global Pint binary..."
    composer global require laravel/pint --quiet
fi

echo "✅ PHP formatting ready!"
echo "   • WordPress projects → phpcbf --standard=WordPress"
echo "   • Everything else → Pint"
echo "   • No more version conflicts or timeouts ever again ❤️"
