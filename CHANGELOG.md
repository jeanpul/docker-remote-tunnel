# Change Log

## Add ssh config file parameter

To provides more flexibility in the ssh tunnel configuration, you can submit a ssh config file.

### Usage:

Run a container, and map the path to your ssh key and a ssh configuration file

```
$ docker run -v ~/.ssh/id_rsa:/tmp/key -v ~/.ssh/config:/tmp/config -it ruanbekker/docker-remote-tunnel sh
```
