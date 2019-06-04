# Tor Docker Compose Scripts

The Docker Compose scripts here will allow you to install these web applications locally and as [Tor onion services](https://2019.www.torproject.org/docs/onion-services.html.en). 

Each compose scripts should have two main parts:

1. The Tor service
2. The web application

### Tor Service Example:

```
  tor:
     build: tor_build/
     links:
          - ghost
     restart: always
# Keep keys in volumes
     volumes:
          - ".tor/:/var/lib/tor/hidden_service/"
     environment:
        # Set mapping ports
         GHOST_PORTS: "80:2368"
```

In this example, the Tor service will be built from source to ensure that you are getting the latest version of the code and that it is compatible with your CPU architecture. Also, the .onion service will be publishing this app on port 80 while the app is expecting it to be coming in on port 2368. 

### Web Application Example:

```
  ghost:
     build: ghost_build/
     restart: always
     ports:
             - 2368:2368
```

In this example you can see that again we are building the app from source. The app will be available locally as http://localhost:2368. Remove the *ports* lines in order to make this app only available as an onion service and not a locally available service.

### About [Tor](https://torproject.org)

The Tor image was originally published [here](https://github.com/cmehay/docker-tor-hidden-service) by [cmehay](https://github.com/cmehay). My fork is [here](https://github.com/tgeek77/tor-hidden-service). All images in this repository will be based on my [v3 Onion](https://github.com/tgeek77/tor-hidden-service/tree/v3) branch.

Note:
Not all scripts have been updated yet. I will be updating them to build the app and the Tor service from source as I have time. All scripts are testing on both x86 and ARM64 architectures.

### How to find my .onion address

A simple script called *v3onions* is available in the Tor container to get the .onion url when the container is running.

```
$ docker exec my_tor_container v3onions
/var/lib/tor/hidden_service/my_tor_container/hostname
p7gyaqryx6hru34lodxorn7cr6jglnpe3huwzqffo6mogwkfwn6d7iyd.onion
```
