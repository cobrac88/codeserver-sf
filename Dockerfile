FROM docker.io/linuxserver/code-server:latest

# Installeer curl, jq (JSON parser) en Java (nodig voor Salesforce Apex extensies)
RUN apt-get update && \
    apt-get install -y curl jq default-jre-headless && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g @salesforce/cli@latest && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
