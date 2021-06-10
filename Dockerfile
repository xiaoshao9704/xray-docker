FROM alpine:latest

WORKDIR /xray

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk update
RUN apk add nginx openssl certbot-nginx supervisor --no-cache

COPY ./bin /xray/bin
COPY ./xray-core /xray/xray-core
COPY ./supervisor /etc/supervisor
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN sh ./bin/install.sh

EXPOSE 443 80

CMD [ "sh", "/xray/bin/start.sh" ]