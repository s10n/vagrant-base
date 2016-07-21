#!/bin/bash

# 우분투 설정: 프롬프트
echo 'source ~/.dotfiles/.bash_profile' >> .profile

# 우분투 설정: 배포 키 파일 권한
chmod 400 .ssh/id_rsa

# 우분투 설정: 소스 리스트
sudo sed -i "s@us.archive.ubuntu.com@kr.archive.ubuntu.com@" /etc/apt/sources.list
sudo sed -i "s@http://archive.ubuntu.com@http://kr.archive.ubuntu.com@" /etc/apt/sources.list
sudo apt-get update -y

# 패키지 설치: 필수 패키지들
sudo apt-get install -y build-essential
sudo apt-get install -y python
sudo apt-get install -y git
sudo apt-get install -y nginx

# 패키지 설치: Node.js
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g bower grunt-cli

# Git 환경 설정
if [ ! -f ".gitconfig" ]; then
  touch .gitconfig;
  cat >> .gitconfig << EOT
[include]
  path = ~/.dotfiles/.gitconfig
EOT
fi

# 버전 확인
echo ''
echo 'SSH Key:'
cat .ssh/id_rsa.pub
echo ''
echo '패키지 설치 상태:'
python --version
nginx -v
git --version
echo "Node $(node --version)"
echo "Bower $(bower --version)"
grunt --version
