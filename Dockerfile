FROM docker.io/linuxserver/code-server:latest

# Install curl, jq, Java JDK (including javac), zip/unzip, Node.js, SF CLI and Prettier
RUN apt-get update && \
    apt-get install -y curl jq default-jdk-headless zip unzip && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g @salesforce/cli@latest prettier @prettier/plugin-xml && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
