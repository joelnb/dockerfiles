# Ansible Documentation

Server a local copy of the [Python documentation site](https://docs.python.org/) from a Docker container.

## Building

To select a version of Python to build documentation for you should set the `PYTHON_VERSION` build argument to a valid tag/branch in the cpython git repo. An example command to build the docs for version 2.7 is:

```
docker build --build-arg PYTHON_VERSION=2.7 -t joelnb/python-docs:local python-docs
```
