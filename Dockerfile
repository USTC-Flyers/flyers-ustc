FROM node:10.19.0-alpine3.11 AS builder

RUN mkdir /app

WORKDIR /app

COPY ./frontend/ /app/frontend

RUN cd /app/frontend && npm install --registry=https://registry.npm.taobao.org/

RUN cd /app/frontend && npm run build

FROM nginx:stable-alpine
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=builder /app/frontend/dist /usr/share/nginx/frontend

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]