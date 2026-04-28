# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-04-28

### Changed

- Base image switched from `mhart/alpine-node:12.4.0` to `alpine:3.19` (Node.js dropped — it was unused).
- Docker CLI upgraded to 25.x via the `docker-cli` Alpine package.
- Docker Compose upgraded from v1 (pip) to **v2.23.x** via the `docker-cli-compose` Alpine package. Compose file format **3.8** is now supported.
- Image is now published as `jeanpul/docker-remote-tunnel`.

### Removed

- Build-time toolchain (`gcc`, `python-dev`, `libffi-dev`, `openssl-dev`, `libc-dev`, `make`, `py-pip`) — no longer needed since Compose v2 ships as a native binary.
- `docker-compose` v1 binary. Use `docker compose` (subcommand) instead.

### Breaking

- Anything calling `docker-compose ...` must be updated to `docker compose ...`.

## [1.x] - Pre-fork

Original work by [ruanbekker/docker-remote-tunnel](https://hub.docker.com/r/ruanbekker/docker-remote-tunnel). Added support for an SSH config file mounted at `/tmp/config`.
