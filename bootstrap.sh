#!/usr/bin/env bash

# 설정: 프롬프트 색상
sed -i 's@#force_color_prompt=yes@force_color_prompt=yes@' /home/vagrant/.bashrc

# 설정: 소스 리스트
sudo sed -i 's@us.archive.ubuntu.com@kr.archive.ubuntu.com@' /etc/apt/sources.list
sudo sed -i 's@http://archive.ubuntu.com@http://kr.archive.ubuntu.com@' /etc/apt/sources.list

# 설정: 소스 리스트 (NGINX)
# http://nginx.org/en/linux_packages.html
wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key && rm $_
echo "deb     http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list
echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list
sudo apt-get update -y

# 패키지 설치: Essential
sudo apt-get install -y build-essential
sudo apt-get install -y python

# 패키지 설치: NGINX
sudo apt-get install -y nginx

# 패키지 설치: Git
# https://git-scm.com/book/ko/v2/시작하기-Git-설치#소스코드로-설치하기
if [ "$(git --version)" != "git version 2.9.0" ]; then
  sudo apt-get install -y libcurl4-gnutls-dev libexpat1-dev gettext \
    libz-dev libssl-dev
  sudo apt-get install -y asciidoc xmlto docbook2x
  sudo apt-get install -y autoconf
  wget https://github.com/git/git/archive/v2.9.0.tar.gz
  tar -zxf v2.9.0.tar.gz && rm $_
  cd git-2.9.0
  make configure
  ./configure --prefix=/usr
  make all doc info
  sudo make install install-doc install-html install-info
  rm -rf /home/vagrant/git-2.9.0
fi

# 패키지 설치: Python
sudo apt-get install -y python-setuptools
sudo easy_install pip
sudo pip install virtualenv

# 패키지 설치: Node.js
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g bower grunt-cli
