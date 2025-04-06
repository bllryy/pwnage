FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    nsjail \
    socat \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create the restricted user
RUN useradd -m -u 31337 ctf

# Set up challenge directory
RUN mkdir -p /srv/app && chown root:ctf /srv/app && chmod 750 /srv/app

# Copy in entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Run as ctf user inside /srv/app
USER ctf
WORKDIR /srv/app

EXPOSE 1337
ENTRYPOINT ["/entrypoint.sh"]
