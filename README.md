# docker-remote-tunnel

Run Remote Docker commands via a SSH Tunnel.

## Description

This wrapper simplifies ci/cd deployments (e.g. with Concourse) to deploy applications to a Docker Swarm.

It creates a `screen` session and an SSH tunnel that maps a local port to the Docker socket on the manager node, allowing you to run `docker` and `docker compose` commands locally against the remote Docker API.

The image is based on `alpine:3.19` and ships:

- `docker` CLI 25.x
- `docker compose` v2 (supports Compose file format up to **3.8**)
- `openssh-client`, `screen`, `openssl`, `apache2-utils`

## Usage:

Build the image locally:

```
$ docker build -t docker-remote-tunnel .
```

Run a container, and map the path to your ssh key:

```
$ docker run -v ~/.ssh/id_rsa:/tmp/key -it docker-remote-tunnel sh
```

If you need a custom SSH config (jump host, identity file, etc.), mount it as well:

```
$ docker run -v ~/.ssh/id_rsa:/tmp/key -v ~/.ssh/config:/tmp/config -it docker-remote-tunnel sh
```

Wrapper supports creating and terminating the tunnels:

```
$ docker-tunnel --help

Usage: /usr/bin/docker-tunnel
Description: Execute remote docker commands via ssh tunnel over a docker socket

 -h, --help                    Display usage instructions
 -c, --connect [user@foo.bar]  Establishes Tunnel to Remote SSH Server. Expects username@remote-server
 -t, --terminate               Terminates Tunnel
```

Establish a SSH Tunnel to your Manager node:

```
$ docker-tunnel -c root@manager.docker.example.com

  Source the environment either with:

  1) source /root/.docker-tunnel.sh
  2) export DOCKER_HOST="localhost:2376"

```

Source the environment:

```
$ source /root/.docker-tunnel.sh
```

Validate that the DOCKER_HOST variable has been set:

```
$ env | grep DOCKER
DOCKER_HOST=localhost:2376
```

Run a docker command from the container:

```
$ docker node ls
ID                            HOSTNAME            STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
9kbmvcr73ceh2afozxrwx3CzT *   swarm-manager-1     Ready     Active         Leader           25.0.5
vuxEvsv09qvRekwcltk7prmkx     swarm-worker-1      Ready     Active                          25.0.5
```

Or deploy a stack with Compose v2 (file format 3.8 supported):

```
$ docker stack deploy -c docker-compose.yml my-stack
```

Terminate the tunnel:

```
$ docker-tunnel --terminate
```

Verify that the tunnel has been terminated:

```
$ docker node ls
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

## Release

The current version is tracked in the [`VERSION`](VERSION) file and changes are listed in [`CHANGELOG.md`](CHANGELOG.md). Versioning follows [SemVer](https://semver.org).

To cut a new release:

1. **Bump the version**: edit [`VERSION`](VERSION) (e.g. `2.0.0` → `2.1.0`).
2. **Update the changelog**: add a new section to [`CHANGELOG.md`](CHANGELOG.md) describing the changes.
3. **Commit and tag**:
   ```
   $ git add VERSION CHANGELOG.md
   $ git commit -m "Release v2.1.0"
   $ git tag v2.1.0
   $ git push && git push --tags
   ```
4. **Build and publish the image** to Docker Hub (`jeanpul/docker-remote-tunnel`):
   ```
   $ VERSION=$(cat VERSION)
   $ docker build \
       --build-arg version=${VERSION} \
       --build-arg build_date=$(date -u +%Y-%m-%dT%H:%M:%SZ) \
       -t jeanpul/docker-remote-tunnel:${VERSION} \
       -t jeanpul/docker-remote-tunnel:latest \
       .
   $ docker push jeanpul/docker-remote-tunnel:${VERSION}
   $ docker push jeanpul/docker-remote-tunnel:latest
   ```

The image is then pullable from Docker Hub:

```
$ docker pull jeanpul/docker-remote-tunnel:2.0.0
```

## Credits

Originally based on [ruanbekker/docker-remote-tunnel](https://hub.docker.com/r/ruanbekker/docker-remote-tunnel).

