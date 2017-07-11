This image bundles nginx with a module for performing HTTP digest
authentication. The default configuration has a single path `/private`
protected by the credentials `admin:admin`.

# Notice

I created this due to a need to test digest authentication from a client but
I would advise against running it in production as the nginx-http-auth-digest
module seems abandoned.

The [fork](https://github.com/atomx/nginx-http-auth-digest) I am using is more
updated (and actually builds on Alpine) but you should fully vet the code
before using it for anything serious.
