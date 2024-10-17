# Use the official Composer image
FROM composer:2

# Set build arguments for user ID, group ID, and username
ARG UID
ARG GID
ARG USER

# Set environment variables for the build
ENV UID=${UID}
ENV GID=${GID}
ENV USER=${USER}

# Remove the dialout group (not needed)
RUN delgroup dialout

# Create a system group and user for the specified UID and GID
RUN addgroup -g ${GID} --system ${USER} \
    && adduser -G ${USER} --system -D -s /bin/sh -u ${UID} ${USER}

# Set the working directory for Composer
WORKDIR /var/www/html

# Optionally set the user for running Composer commands (commented out)
# USER ${USER}

# Set entrypoint for Composer
ENTRYPOINT ["composer"]

# Default command to ignore platform requirements
CMD ["--ignore-platform-reqs"]
