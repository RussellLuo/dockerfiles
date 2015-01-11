# Dockerfile for building Python-2.7 images
# Based on phusion/baseimage:latest

FROM phusion/baseimage:latest
MAINTAINER RussellLuo <luopeng.he@gmail.com>

# install Python 2.7
RUN apt-get update && apt-get install -y python2.7
RUN ln -s /usr/bin/python2.7 /usr/bin/python
