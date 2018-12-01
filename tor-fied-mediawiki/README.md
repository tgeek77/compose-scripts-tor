# tor-fied-wiki
## Intro

This is a docker-compose script for creating a simple MediaWiki installation.

### Special thanks to:

[cmehay](https://github.com/cmehay/docker-docker-tor-hidden-service)
[synctree](https://github.com/synctree/docker-mediawiki)

for their projects which allowed me to build this one.

### About the script:
In truth, very little was done apart from copying and pasting from the two above mentioned projects into a new docker-compose file and tailoring it a little to make the two projects works together. 

#### Variables

Volumes: By default, docker-compose will create a ~/.keys directory with the hostname and private key.  You can change the local directory whatevery you want

Passwords: Change the mysql root and user passwords to something other than the default passwords.  

```
$ docker-compose up -d
```
#### What's my .onion url?

Your new .onion hostname will be in ~/.keys/wiki/hostname or you can run the following command:

```
$ docker exec -ti torfiedwiki_tor_1 onions
```

### Problems
* email isn't working
* the env variables aren't being recognized for mediawiki so they have to be put in manually via the installer script.

