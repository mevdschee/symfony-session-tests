# Symfony session handler test suite

This repository contains a test suite for the Symfony session save handlers (to test locking support). Current handlers that are tested are:

- default: [NativeFileSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/NativeFileSessionHandler.php) - uses the "files" session module.
- pdo_mysql: [PdoSessionHandler](https://github.com/symfony/symfony/blob/6.3/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/PdoSessionHandler.php) - stores data in MySQL using PDO.
- memcached: [MemcachedSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/MemcachedSessionHandler.php) - stores data in Memcache (fails: no locking).
- redis: [RedisSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/RedisSessionHandler.php) - stores data in Redis (fails: no locking).

## Requirements

You can install the dependencies of this script using:

    sudo apt install php-cli php-curl

Optional dependencies can be installed using:

    sudo apt install memcached php-memcached redis php-redis php-mysql

You can install the Symfony dependencies of this script using:

    wget getcomposer.org/composer.phar
    php composer.phar install

You need PHP 7.4 or higher to run the code.

## Using the handlers

See: [Store Sessions in a Database](https://symfony.com/doc/current/session/database.html)

## Running the tests

You should prepare your MySQL database by running the SQL script:

    cat create_mysql_symfony_session_test_db.sql | sudo mysql

You can run the tests from the command line using:

    php run-tests.php

The code will execute in about 1 second and test 14 HTTP calls in 3 save handlers. The following output would mean that the tests succeeded and locking is implemented correctly (which is not the case):

    default   : OK
    pdo_mysql : OK
    memcached : OK
    redis     : OK

The word "FAILED" appears on a failed test and "SKIPPED" is shown when the PHP module is not loaded for either Redis or Memcache.

## Stress testing

Use this for 100 runs:

    for i in `seq 1 100`; do php run-tests.php silent; done

As shown, you may use the argument "silent" to suppress output on successful or skipped tests.
