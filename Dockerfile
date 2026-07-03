FROM docker.io/linuxserver/code-server:latest

# Stel in dat Playwright de browsers op een gedeelde, universele locatie installeert
ENV PLAYWRIGHT_BROWSERS_PATH=/opt/playwright

# Install curl, jq, Java JDK, zip/unzip, Node.js, SF CLI, Prettier én Playwright OS-dependencies
RUN apt-get update && \
    apt-get install -y curl jq default-jdk-headless zip unzip \
    libnss3 libnspr4 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    libxkbcommon0 libxcomposite1 libxdamage1 libxext6 libxfix6 \
    librandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2 && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    # Installeer global CLI's (SF, Prettier en de Playwright test runner)
    npm install -g @salesforce/cli@latest prettier @prettier/plugin-xml @playwright/test && \
    # Download de Chromium browser direct in de image op de universele locatie
    npx playwright install chromium && \
    # Rechten goedzetten zodat de 'abc' gebruiker er straks bij kan
    chmod -R 777 /opt/playwright && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
