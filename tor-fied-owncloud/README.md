# tor-fied-wordpress
## Intro

This is a docker-compose script for creating a simple wordpress hidden service onion.

### Special thanks to [cmehay](https://github.com/cmehay/docker-tor-hidden-service) and to the [Wordpress project](https://hub.docker.com/_/wordpress/) for their projects which allowed me to build this one.

### About the script:
In truth, very little was done apart from copying and pasting from the two above mentioned projects into a new docker-compose file and tailoring it a little to make the two projects works together. 

#### Variables

Volumes: By default, docker-compose will create a ~/.keys directory with the hostname and private key.  You can change the local directory whatevery you want

Passwords: Change the mysql root and user passwords to something other than the default passwords.  Make sure that MYSQL_PASSWORD and WORDPRESS_DB_PASSWORD are the same password as they are referring to the same thing.

```
$ docker-compose up -d
```
#### What's my .onion url?

Your new .onion hostname will be in ~/.keys/wordpress/hostname or you can run the following command:

```
$ docker exec -ti torfiedwordpress_tor_1 onions
```

#### Other applications

I've used this process to create several other hidden service applications such as tomcat, jboss, as well as more commonplace webservers like apache and nginx.
