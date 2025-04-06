# pwnage

A simple Docker image for deploying CTF pwnable challenges in lightweight, jail-secured environments.

![I will pwn u](./2025-04-06_00-24.png)

## What is this?

`pwnage` is a slimmed-down Docker image you can use as the foundation for all your pwnable challenges. It wraps your binary in `nsjail` and exposes it over TCP using `socat`, so all you have to do is:

```Dockerfile
FROM pwnage

COPY chall /srv/app/run
COPY flag.txt /srv/app/flag.txt
RUN chmod 755 /srv/app/run
```
### Whats running inside?

- Debian Bullseye slim base
- nsjail for sandboxing
- socat for TCP listener
- Non-root ctf user (UID 31337)
- Automatic jail per connection (via entrypoint.sh)
- /srv/app is the only writable, accessible zone


## Things to know before you pwn.
 - Your binary MUST be in /srv/app/run and executable.

- The container will listen on port 1337 as default.

 - Every connection gets a new nsjail instance.

 - If you want to customize nsjail settings, consider baking in your own config file and updating entrypoint.sh accordingly.

 - No internet access, no /proc, no root — your binary should be self-contained.

 - Runs as a non-root user inside the container for added safety.

## File Structure.

```
/srv
└── app
    ├── run        # your challenge binary
    └── flag.txt   # optional, read-only inside the jail
```
