# Dockerfile for building development images
# Based on phusion/baseimage:latest

FROM phusion/baseimage:latest
MAINTAINER RussellLuo <luopeng.he@gmail.com>


# ## Enable SSH ##
RUN rm -f /etc/service/sshd/down


# ## Install SSH keys ##

# Add `id_rsa` and `id_rsa.pub` into /tmp
COPY .ssh /tmp/

# Use SSH keys of the host for the root user in the container
RUN cp /tmp/id_rsa /root/.ssh
RUN cp /tmp/id_rsa.pub /root/.ssh

# Make proper permissions
RUN chmod 700 /root/.ssh && \
    chmod 644 /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa

# The host can login to the container via SSH now
RUN cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys

# Clear up
RUN rm -rf /tmp/.ssh


# ## Change Ubuntu Source list ##
RUN sed 's/http:\/\/archive.ubuntu.com/http:\/\/cn.archive.ubuntu.com/g' \
    -i /etc/apt/sources.list


# ## Use more proper DNS in China ##
RUN echo 'nameserver 114.114.114.114' >> /etc/resolvconf/resolv.conf.d/base


# ## Add the installation script ##
COPY install.sh /root/
