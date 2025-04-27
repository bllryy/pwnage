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

- Ubuntu Latest
- nsjail for sandboxing
- socat for TCP listener
- Non-root ctf user (UID 31337)
- Automatic jail creation for each connection
- Minimal writable filesystem (/srv/app only)


## Things to know before you pwn.
- Your binary MUST be placed at /srv/app/run and be executable
- The container listens on port 1337 by default (configurable via PORT environment variable)
- Every connection spawns a new nsjail instance for isolation
- Custom nsjail settings can be provided by modifying the configuration and entrypoint.sh
- The environment is deliberately restrictive - your binary should be self-contained
- The challenge runs as a non-root user for added security

## Advanced Usage
### Custom Port
``` docker run -p 9999:1337 -e PORT=1337 my-challenge ```

### Custom Resource Limits
``` docker run -e TIME_LIMIT=30 -e MEM_LIMIT=64 -e PROC_LIMIT=10 my-challenge ```

## File Structure.

```
/srv
└── app
    ├── run        # your challenge binary
    └── flag.txt   # optional, read-only inside the jail
```

# Please Contribute and Change things!
