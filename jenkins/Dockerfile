
FROM jenkins/jenkins:lts-jdk17

USER root

# Install Python, pip, virtual environment support, and required utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    python3 \
    python3-pip \
    python3-venv \
    tar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN curl -SL \
    https://download.docker.com/linux/static/stable/x86_64/docker-27.5.1.tgz \
    -o /tmp/docker.tgz && \
    tar -xzf /tmp/docker.tgz -C /tmp && \
    cp /tmp/docker/docker /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker && \
    rm -rf /tmp/docker /tmp/docker.tgz

# Install Docker Compose
RUN curl -SL \
    https://github.com/docker/compose/releases/download/v2.39.2/docker-compose-linux-x86_64 \
    -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Local learning environment only: root accesses the Docker socket
USER root
