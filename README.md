# Joel's Dockerfiles

These are some Dockerfiles which I maintain either for my own use
or for testing. The things I actually use are likely to be better
maintained but I am happy to accept pull requests for anything.

## Getting the images

The images are all available as automated builds under [my user
on docker hub](https://hub.docker.com/u/joelnb/) and can therefore
be retrieved with a command like:

```
docker pull joelnb/gollum
```

## Building the images

A utility script is provided for building images. You can either
build a single image with:

```
./build.sh gollum
```

Or build all images by passing no arguments:

```
./build.sh
```

Everything is built using standard Docker commands so feel free
to roll your own commands if you prefer.
