FROM nginx:latest

# drop symlinks
RUN unlink /var/log/nginx/access.log
RUN unlink /var/log/nginx/error.log

RUN rm /etc/nginx/nginx.conf

# Copy nginx.conf file
COPY nginx.conf /etc/nginx/nginx.conf


# Copy index.html file
COPY index.html /usr/share/nginx/html/index.html

# Create log directory
RUN mkdir -p /var/log/nginx

# Set permissions
RUN chown -R nginx:nginx /var/log/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
