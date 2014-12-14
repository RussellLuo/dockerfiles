# Dockerfile for building MongoDB images
# Based on phusion/baseimage:latest

FROM phusion/baseimage:latest
MAINTAINER RussellLuo <luopeng.he@gmail.com>

# Update apt-get sources AND install MongoDB/supervisor
RUN apt-get update && apt-get -y install mongodb-server supervisor

# Copy config files
ADD	./supervisord.conf /etc/supervisor/conf.d/
ADD	./init-replicaset.conf /etc/supervisor/conf.d/
ADD	./mongodb.conf /etc/
ADD	./bootstrap.sh /tmp/

# Set /tmp/bootstrap.sh as the dockerized entry-point application
ENTRYPOINT ["/bin/bash", "/tmp/bootstrap.sh"]
