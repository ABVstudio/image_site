FROM nginx:latest

EXPOSE 80
EXPOSE 443
EXPOSE 666

COPY nginx.conf /etc/nginx/nginx.conf
COPY ./dist /var/www

WORKDIR /etc/nginx/ssl/
RUN apt-get update
RUN apt-get install -y openssl
RUN openssl req -nodes -new -x509 -keyout tls.key -out tls.crt -subj "/C=US/ST=State/L=City/O=company/OU=Com/CN=www.testserver.local"

CMD ["nginx"]
