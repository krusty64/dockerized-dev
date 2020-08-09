# dockerized-dev

A set of Dockerfile's that allow developing in a variety of languages without
installing the toolchain on the host machine.

## VSCode remote

Since VSCode does not allow remote-ssh and remote-container in sequence, these
are containers that already contain an ssh server. This allows me to run 
VSCode on my chromebook and the container on some linux host reachable by SSH.

## Mount

The images will mount the `$HOME/src` directory of the user starting the
container. The security within the container is minimal, as it should not be
accessible from a public IP.

Hosting these containers somewhere in the cloud only works you create an SSH
tunnel to port `22222` of the host machine (do not open that port in the
firewall!)

## Rust

To run a rust container, simply `cd` into the rust directory and run the shell
script.

```sh
cd dockerized-dev/rust
sh run-rust.sh
```

To terminate it, call

```sh
docker kill rust-dev
```
