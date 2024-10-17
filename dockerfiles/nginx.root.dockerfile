FROM nginx:stable-alpine

# Change the user from 'nginx' to 'root' in the Nginx configuration
RUN sed -i "s/user  nginx/user root/g" /etc/nginx/nginx.conf

# Copy the Nginx configuration file to the correct directory
ADD ./nginx/default.conf /etc/nginx/conf.d/

# Create the document root directory
RUN mkdir -p /var/www/html
