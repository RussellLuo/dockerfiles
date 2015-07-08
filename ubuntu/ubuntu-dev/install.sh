#!/usr/bin/env bash
# -*- coding: utf-8 -*-


# Install git
sudo apt-get update
sudo apt-get -y install git

# Config git
git config --global user.name "RussellLuo"
git config --global user.email "luopeng.he@gmail.com"
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.pu "!git pull --rebase upstream master"

# Install tig
sudo apt-get -y install tig

# Install oh-my-zsh
sudo apt-get -y install zsh
curl -L http://install.ohmyz.sh | sudo sh
sudo chsh -s /bin/zsh

# Install python related packages
sudo apt-get -y install python-dev
sudo apt-get -y install python-virtualenv
sudo pip install flake8

# Install vim (and k-vim)
sudo apt-get -y install vim
git clone https://github.com/RussellLuo/k-vim.git
cd k-vim && sh -x install.sh && cd -

# Install tmux
sudo apt-get -y install tmux

# Install tree
sudo apt-get -y install tree

# Install nginx
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update
sudo apt-get -y install nginx

# Install docker
curl -s https://get.docker.io/ubuntu/ | sudo sh
