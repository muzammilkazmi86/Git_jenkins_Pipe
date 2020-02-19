FROM nginx

## NEW LINE ADDED
RUN rm /usr/share/nginx/html/index.html
## NEW LINE END

COPY index.html /usr/share/nginx/html
