# Ansible Documentation

Server a local copy of the [ansible documentation site](https://docs.ansible.com/) from a Docker container.

## Building

To select a version of ansible to build documentation for you should set the `ANSIBLE_VERSION` build argument to a valid tag/branch in the ansible git repo. An example command to build the docs for version 2.4.0 is:

```bash
docker build --build-arg ANSIBLE_VERSION=v2.4.0.0-1 -t joelnb/ansible-docs:local ansible-docs
```
