FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    socat \
    gcc \
    gdb \
    python3 \
    python3-pip \
    netcat \
    vim \
    curl \
    wget

# Create non-root user for running challenges
RUN useradd -m ctf && \
    mkdir -p /home/ctf/challenge

# Copy challenge files
COPY buffer_overflow.c /home/ctf/challenge/
WORKDIR /home/ctf/challenge

# Compile the challenge binary with security features disabled
RUN gcc -o buffer_overflow buffer_overflow.c -fno-stack-protector -z execstack -no-pie

# Set permissions
RUN chmod +x /home/ctf/challenge/buffer_overflow && \
    chown -R ctf:ctf /home/ctf

# Expose port
EXPOSE 9999

# Start a server that runs the challenge
CMD ["socat", "TCP-LISTEN:9999,reuseaddr,fork", "EXEC:/home/ctf/challenge/buffer_overflow"]