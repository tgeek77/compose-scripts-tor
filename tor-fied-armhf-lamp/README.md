# tor-fied-armhf-lamp
## Repository
https://github.com/tgeek77/tor-fied-armhf-lamp

```
git clone https://github.com/tgeek77/tor-fied-armhf-lamp
```

## Intro

These are docker-compose and dockerfile scripts for creating a simple vanilla lamp stack running as a hidden service onion.

## Special thanks to:

 [goldy](https://hub.docker.com/r/goldy/tor-hidden-service/) for his project which allowed me to build this one.

## About the scripts:

docker-compose.yml calls on three images:

jsevans/docker-tor-armhf-hidden-service
This is my ARM port of the https://hub.docker.com/r/goldy/tor-hidden-service/ image.

jsevans/marias-arm
This is my ARM port of the official mariadb image.

jsevans/apache-arm
This is my own image that installs a list of packages including apache2, php, and some standard dependancies. The list of packages can be changed or added to as needed for your own personal needs.

#### Variables

Volumes: In the tor section, docker-compose will create a ~/.keys directory with the hostname and private key.  In the apache section, it create ~/www which links to /var/www/html in the apache container. By default you will not be able to write to this directory. Use chmod to change permissions to something that you can use. You can change this local directory to whatever you want.

Passwords: **Change all passwords to something other than the default passwords!** I included a basic starter database in the configuration to ease in setting up something like wordpress or whatever.

#### Build & Run!

```
docker-compose build
docker-compose up -d
```
you can now start running your app!

#### Stop and remove

```
docker-compose down
```

#### What's my .onion url?

Your new .onion hostname will be in ~/.keys/wordpress/hostname or you can run the following command:

```
$ docker exec -ti torfiedarmhflamp_tor_1 onions
```

#### Setting up LAMP applications

I have successfully installed Joomla, Wordpress, Koken, and phpMyAdmin using this project.

Joomla, Wordpress, etc. -- the database location should not be "localhost", instead it should be "db" as that is how you can connect to the remote database container.

phpMyAdmin -- download and install the file from https://www.phpmyadmin.net/. Rename config.sample.inc.php to config.inc.php and make the following change:

```
$cfg['Servers'][$i]['host'] = 'localhost';
```

Should be changed to:

```
$cfg['Servers'][$i]['host'] = 'db';
```

You can then run phpMyAdmin using the mariadb root and password settings from docker-compose.yml
