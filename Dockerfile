FROM nginx:1.29-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY app/ /usr/share/nginx/html/

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]