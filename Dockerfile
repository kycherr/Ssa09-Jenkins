FROM nginx:latest

RUN unlink /var/log/nginx/access.log
RUN unlink /var/log/nginx/error.log

RUN rm /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/nginx.conf

COPY index.html /usr/share/nginx/html/index.html

RUN mkdir -p /var/log/nginx

RUN chown -R nginx:nginx /var/log/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
