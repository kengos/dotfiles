# phpenv

## php 5.6

```sh
brew install libpng freetype gettext icu4c jpeg unixodbc re2c libmcrypt
phpenv install 5.6.9
phpenv global 5.6.9
```

phalcon

```sh
cd ~
git clone https://github.com/phalcon/cphalcon --depth=1
cd cphalcon/build
./install
echo "extension=[path/to/extensions/]phalcon.so" >> ~/.anyenv/envs/phpenv/versions/5.6.9/etc/php.ini
```