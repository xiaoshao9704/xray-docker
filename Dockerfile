FROM alpine:latest

WORKDIR /xray

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk add nginx openssl

COPY env.sh install.sh self_signature.sh server.json.template run.sh /xray/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN sh install.sh

EXPOSE 443 80

CMD [ "sh", "/xray/run.sh" ]