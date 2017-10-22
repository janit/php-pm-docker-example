PHP-PM Docker with Symfony example
===========

This is an attempt to run [PHP-PM](https://github.com/php-pm/php-pm) in a Docker image.
The aim is to enable running compatible PHP apps with high performance and no need
for a separate web server (like Nginx or Apache). This would be inline with running
Node.js or Golang apps in containers.

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