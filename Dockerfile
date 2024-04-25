FROM nginx:latest

# Remove default nginx configuration
#RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx configuration
#COPY nginx.conf /etc/nginx/nginx.conf

# Copy index.html file
COPY index.html /usr/share/nginx/html/index.html

# Create log directory
RUN mkdir -p /var/log/nginx

# Set permissions
RUN chown -R nginx:nginx /var/log/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
