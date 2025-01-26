# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-24.04-v4

# Copy init scripts.
COPY init /init
RUN chmod +x /init

COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# Install Qutebrowser and dependencies.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nano \
        qutebrowser \
        fonts-liberation \
        ca-certificates \
        xdg-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP, Composer, Symfony CLI.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        php-cli \
        php-mbstring \
        php-xml \
        php-intl \
        php-simplexml \
        php-curl \
        php-mysql \
        php-sqlite3 \
        php-zip \
        php-gd \
        unzip \
        curl \
        git && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Node.js and npm.
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create /recursos directory with proper permissions.
RUN mkdir -p /recursos && chmod 755 /recursos

# Install code-server in /recursos.
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/recursos/code-server

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-liberation \
        fonts-dejavu-core \
        fonts-noto-core \
        fonts-noto-color-emoji \
        fonts-firacode \
        fonts-roboto-unhinted \
        fonts-ubuntu && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set environment variables.
RUN set-cont-env APP_NAME "Symfony KSPERU"