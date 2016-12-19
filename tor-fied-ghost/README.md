# tor-fied-ghost
## Intro

This is a docker-compose script for creating a simple Ghost installation.

### Special thanks to:

[cmehay](https://github.com/cmehay/docker-tor-hidden-service)
[ghost](https://hub.docker.com/_/ghost/)

for their projects which allowed me to build this one.

### About the script:
In truth, very little was done apart from copying and pasting from the two above mentioned projects into a new docker-compose file and tailoring it a little to make the two projects works together. 

#### Variables

Volumes: By default, docker-compose will create a ~/.keys directory with the hostname and private key.  You can change the local directory whatevery you want

```
$ docker-compose up -d
```
#### What's my .onion url?

Your new .onion hostname will be in ~/.keys/ghost/hostname or you can run the following command:

```
$ docker exec -ti torfiedghost_tor_1 onions
```

### Problems
* email isn't working -- see http://support.ghost.org/mail for more help with that.

