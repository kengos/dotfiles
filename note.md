## ruby

### install

```sh
brew link readline --force
export CFLAGS=-Wno-error=shorten-64-to-32
CONFIGURE_OPTS="--with-readline-dir=/usr/local --with-openssl-dir=`brew --prefix openssl`" RUBY_CONFIGURE_OPTS="--with-openssl-dir=`brew --prefix openssl`" rbenv install 2.2.1
brew unlink readline
```

### settings

```sh
rbenv global 2.2.1
reload
gem install bundler
rbenv rehash
```
