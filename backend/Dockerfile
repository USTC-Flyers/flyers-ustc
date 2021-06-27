FROM python:3.8-buster
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN echo \
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free \
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free \
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free \
    > /etc/apt/sources.list && \
    apt update && \
    apt-get install python3 libpq-dev && \
    wget https://cdn.jsdelivr.net/gh/vishnubob/wait-for-it@master/wait-for-it.sh && \
    chmod +x /wait-for-it.sh
RUN mkdir /app
COPY requirements.txt /app
WORKDIR /app
# RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt 
RUN pip3 install -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY . .
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]