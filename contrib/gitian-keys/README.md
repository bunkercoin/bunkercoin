PGP keys
========

This folder contains the public keys of developers and active contributors.

The keys are mainly used to sign git commits or the build results of gitian
builds.

You can import the keys into gpg as follows. Also, make sure to fetch the
latest version from the key server to see if any key was revoked in the
meantime.

Currently there are the keys of:
Yoyois
Mattyinnit/IdotMaster1
Hoiboy19/sys-256

```sh
gpg --import ./*.pgp
gpg --refresh-keys
```
