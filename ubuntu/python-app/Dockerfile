# Dockerfile for building Python-App images
# Based on phusion/baseimage:latest

FROM phusion/baseimage:latest
MAINTAINER RussellLuo <luopeng.he@gmail.com>

# install Python AND pip
RUN apt-get update && apt-get install -y build-essential python-dev python-pip

# Install dependencies of the app
RUN mkdir /app
ADD ./requirements.txt /app/
WORKDIR /app
RUN pip install -r requirements.txt -i http://pypi.douban.com/simple
