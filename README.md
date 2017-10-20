PHP-PM Docker with Symfony example
===========

This is an attempt to run [PHP-PM](https://github.com/php-pm/php-pm) in a Docker image.
The aim is to enable running compatible PHP apps with high performance and no need
for a separate web server (like Nginx or Apache).

## Installation

Make sure you've got Docker installed and working as expected.

Build the image (see [Dockerfile](./Dockerfile) for details):

```
$ docker build --tag=ppmtest .
```

This will take some time, but once you've got it running you can run it as follows:

```
$ docker run -p 8080:8080 ppmtest:latest 
```

Note that this is currently not working as it results in the following error:

```
PHP Fatal error:  Uncaught Symfony\Component\Debug\Exception\ContextErrorException:
Warning: Declaration of PHPPM\React\HttpResponse::setHeaders($headers) should be
compatible with RingCentral\Psr7\MessageTrait::setHeaders(array $headers) in
/vendor/php-pm/php-pm/React/HttpResponse.php:5
```

This project is uploaded to demostrate this and is referenced in a 
[ticket](https://github.com/php-pm/php-pm/issues/276), which is the best way to
track progress on this.