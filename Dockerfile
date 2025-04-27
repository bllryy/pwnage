# Previous Debian-based image
# FROM debian:bullseye-slim

FROM alpine:latest

# Install dependencies
RUN apk update && \
    apk add --no-cache \
    build-base \
    libnl3-dev \
    protobuf-dev \
    libseccomp-dev \
    libtool \
    pkgconfig \
    protobuf \
    go \
    bash \
    socat

# Create jail user and directory structure
RUN adduser -D -u 1000 jail && \
    mkdir -p /srv /jail/cgroup/cpu /jail/cgroup/mem /jail/cgroup/pids /jail/cgroup/unified

# Set up challenge directory structure
RUN mkdir -p /srv/app

# Copy challenge files
COPY challenge /srv/app/challenge
COPY run.sh /srv/app/run
RUN chmod +x /srv/app/run /srv/app/challenge

# Default resource limits
ENV JAIL_TIME_LIMIT=60
ENV JAIL_MEM_LIMIT=50
ENV JAIL_PROC_LIMIT=10
ENV JAIL_CPU_LIMIT=100
ENV POW_DIFFICULTY=0

# Run the Jail
CMD ["/jail/run"]

