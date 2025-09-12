FROM alpine

# Dependencies
RUN apk add --no-cache musl-dev
RUN apk add --no-cache gcc
RUN apk add --no-cache make
RUN apk add --no-cache socat

# Copy source and resources
COPY src/res /pwnage
COPY src /pwnage-src
WORKDIR /pwnage-src

# Compile the challenge binary with security features disabled
RUN make

RUN cp /pwnage-src/run /pwnage
WORKDIR /pwnage

RUN chmod -R 550 /pwnage
RUN chmod -R 000 /pwnage-src

# Expose port
EXPOSE 9999

# Start a server that runs the challenge
CMD ["socat", "TCP-LISTEN:9999,reuseaddr,fork", "EXEC:/pwnage/run"]
