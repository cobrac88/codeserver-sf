FROM docker.io/linuxserver/code-server:latest

# Voorkom interactieve prompts tijdens het bouwen in GitHub Actions
ENV DEBIAN_FRONTEND=noninteractive
ENV PLAYWRIGHT_BROWSERS_PATH=/opt/playwright

# Stap 1: Installeer basispakketten en de juiste Playwright OS-dependencies voor Ubuntu 24.04
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    curl jq default-jdk-headless zip unzip gnupg ca-certificates \
    libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    libxkbcommon0 libxcomposite1 libxdamage1 libxext6 libxfixes3 \
    libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2t64 && \
    \
# Stap 2: NodeSource repository toevoegen en Node.js installeren
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs && \
    \
# Stap 3: Global npm packages & Playwright browser setup
    npm install -g @salesforce/cli@latest prettier @prettier/plugin-xml @playwright/test codex-cli && \
    mkdir -p /opt/playwright && \
    npx playwright install chromium && \
    chmod -R 777 /opt/playwright && \
    \
# Stap 4: Opschonen om de image klein te houden
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
