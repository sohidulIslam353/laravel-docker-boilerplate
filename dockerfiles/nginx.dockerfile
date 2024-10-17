FROM nginx:stable-alpine

ARG UID
ARG GID
ARG USER

ENV UID=${UID}
ENV GID=${GID}
ENV USER=${USER}

# Remove dialout group (not needed)
RUN delgroup dialout

# Create a system group and user for Nginx
RUN addgroup -g ${GID} --system ${USER} \
    && adduser -G ${USER} --system -D -s /bin/sh -u ${UID} ${USER}

# Update Nginx to run as the new user
RUN sed -i "s/user  nginx/user ${USER}/g" /etc/nginx/nginx.conf

# Copy the Nginx configuration file
COPY ./nginx/default.conf /etc/nginx/conf.d/

# Create the document root directory
RUN mkdir -p /var/www/html

# Set permissions for the document root (if necessary)
RUN chown -R ${USER}:${USER} /var/www/html

# Expose port 80
EXPOSE 80
