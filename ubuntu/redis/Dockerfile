# Dockerfile for building Redis images
# Based on phusion/baseimage:latest

FROM phusion/baseimage:latest
MAINTAINER RussellLuo <luopeng.he@gmail.com>

# Update apt-get sources AND install Redis
RUN apt-get update && apt-get -y install redis-server

# Expose port #6379 from the container to the host
EXPOSE 6379

# Set /usr/bin/redis-server as the dockerized entry-point application
ENTRYPOINT ["/usr/bin/redis-server"]
