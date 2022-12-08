# Symfony session handler test suite

This repository contains a test suite for the Symfony session save handlers (to test locking support). Current handlers that can be tested are:

- [NativeFileSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/NativeFileSessionHandler.php) - a session handler that uses PHP's ini settings to configure the "files" session module.
- [MemcachedSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/MemcachedSessionHandler.php) - a session handler that stores it's session data in Memcache.
- [RedisSessionHandler](https://github.com/symfony/symfony/blob/6.2/src/Symfony/Component/HttpFoundation/Session/Storage/Handler/RedisSessionHandler.php) - a session handler that stores it's session data in Redis.

## Requirements

You can install the dependencies of this script using:

    sudo apt install php-cli curl

Optional dependencies can be installed using:

    sudo apt install memcached php-memcached redis php-redis

You need PHP 7.4 or higher to run the code.

## Using the handlers

See: [Store Sessions in a Database](https://symfony.com/doc/current/session/database.html)

## Running the tests

You can run the tests from the command line using:

    php run-tests.php

The code will execute in about 1 second and test 12 HTTP calls in 3 save handlers. The following output means that the tests succeeded:

    default   : OK
    memcache  : OK
    redis     : OK

The word "FAILED" appears on a failed test and "SKIPPED" is shown when the PHP module is not loaded for either Redis or Memcache.

Use this for 100 runs:

    for i in `seq 1 100`; do php run-tests.php silent; done

As shown, you may use the argument "silent" to suppress output on successful or skipped tests.
