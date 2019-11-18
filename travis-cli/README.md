# Travis CLI

A docker image containing the Ruby Travis CI CLI tool. Because it is useful to stay logged in it can be a good idea to create a persistent directory to hold the config files used by Travis:

```
docker run --entrypoint /bin/sh -v "$(HOME)/travis-home:/home/travis" -it --rm joelnb/travis-cli
```
