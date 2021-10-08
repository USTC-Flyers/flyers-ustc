FROM node:10.19.0-alpine3.11 AS builder

RUN mkdir /app

WORKDIR /app

COPY ./frontend/ /app/frontend

RUN cd /app/frontend && npm install --registry=https://registry.npm.taobao.org/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --no-cache openssl

RUN cd /app/frontend && npm run build

FROM nginx:stable-alpine
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=builder /app/frontend/dist /usr/share/nginx/frontend

COPY docker/nginx/default.conf /etc/nginx/conf.d/
COPY docker/nginx/options-ssl-nginx.conf /etc/nginx/
COPY docker/nginx/hsts.conf /etc/nginx/
COPY docker/nginx/nginx.sh /customization/

RUN chmod +x /customization/nginx.sh

EXPOSE 80

CMD ["/customization/nginx.sh"]