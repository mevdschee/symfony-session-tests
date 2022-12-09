# Symfony session handler test suite

This repository contains a test suite for the Symfony session save handlers (to test locking support). Current handlers that can be tested (and their corresponding test mode) are:

- **standard**
  - **default** ([NativeFileSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/NativeFileSessionHandler.php))  
    Uses the "files" session module.
- **strict** ([docs](https://www.php.net/manual/en/session.configuration.php#ini.session.use-strict-mode) / [rfc](https://wiki.php.net/rfc/strict_sessions))
  - **pdo_mysql** ([PdoSessionHandler](https://github.com/symfony/symfony/blob/6.3/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/PdoSessionHandler.php))  
    Stores data in MySQL using PDO.
  - **memcached** ([MemcachedSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/MemcachedSessionHandler.php))  
    Stores data in Memcache (fails: no locking).
  - **redis** ([RedisSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/RedisSessionHandler.php))  
    Stores data in Redis (fails: no locking).

Note that the standard mode testable handlers are strict as well, but can't be tested as strict handlers.

## Requirements

You can install the dependencies of this script using:

    sudo apt install php-cli php-curl

Optional dependencies can be installed using:

    sudo apt install memcached php-memcached redis php-redis php-mysql

You can install the Symfony dependencies of this script using:

    wget getcomposer.org/composer.phar
    php composer.phar install

You need PHP 7.4 or higher to run the code.

## Running the tests

You should prepare your MySQL database by running the SQL script:

    cat create_mysql_symfony_session_test_db.sql | sudo mysql

You can run the tests from the command line using:

    php run-tests.php

The code will execute in about 1 second per handler and test 104 HTTP calls for each handler. The following output would mean that the tests succeeded and locking is implemented correctly (which is not the case):

    standard - default   : OK
    strict   - pdo_mysql : OK
    strict   - memcached : OK
    strict   - redis     : OK

The word "FAILED" appears on a failed test and "SKIPPED" is shown when the PHP module is not loaded for either Redis or Memcache.

## Stress testing

Use this for 100 runs:

    for i in `seq 1 100`; do php run-tests.php silent; done

As shown, you may use the argument "silent" to suppress output on successful or skipped tests.

## Links

Below you find some more interesting information about Symony, Sessions and locking:

- https://github.com/mintyphp/session-handlers (Locking handler implementations)
- https://symfony.com/doc/current/session/database.html (Symfony Session documentation)

Enjoy!
