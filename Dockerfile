# frontend builder
FROM node:16-alpine AS node_builder

RUN mkdir -p /app/frontend
# install package
WORKDIR /app/frontend
COPY ./frontend/package.json /app/frontend/

RUN yarn config set registry https://registry.npmmirror.com && yarn

COPY ./frontend/ /app/frontend/

RUN yarn build

# backend builder
FROM python:3.9-buster
ENV DJANGO_SETTINGS_MODULE=flyers.settings.prod

RUN mkdir -p /app/backend
WORKDIR /app/backend

# install package
COPY ./backend/requirements.txt /app/backend/
RUN pip3 install -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

COPY ./backend/ /app/backend/

# copy static files
RUN mkdir -p /app/backend/static && python manage.py collectstatic --noinput
COPY --from=node_builder /app/frontend/dist/* /app/backend/static/
# RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

RUN chmod +x ./entrypoint.sh && chmod +x ./wait-for-it.sh
ENTRYPOINT ["./entrypoint.sh"]
