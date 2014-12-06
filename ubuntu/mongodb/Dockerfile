# Dockerfile for building MongoDB images
# Based on phusion/baseimage:latest

FROM phusion/baseimage:latest
MAINTAINER RussellLuo <luopeng.he@gmail.com>

# Update apt-get sources AND install MongoDB
RUN apt-get update && apt-get -y install mongodb-server

# Create the MongoDB data directory
RUN mkdir -p /data/db

# Expose port #27017 from the container to the host
EXPOSE 27017

# Set /usr/bin/mongod as the dockerized entry-point application
ENTRYPOINT ["/usr/bin/mongod"]
