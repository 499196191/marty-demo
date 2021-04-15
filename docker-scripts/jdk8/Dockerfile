FROM openjdk:8

MAINTAINER Marty

# 导入中文字体库
ADD simsun.ttc /usr/share/fonts/

# 设置时间
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone