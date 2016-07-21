# -*- coding: utf-8 -*-

from fabric.api import *
from fabric.colors import *


def vm():
    env.hosts = ['127.0.0.1:2222']
    env.user = 'vagrant'
    env.password = 'vagrant'


def provision():
    print(yellow('우분투 환경설정 파일들을 복사합니다.'))
    run('if [ ! -d ".dotfiles" ]; then mkdir .dotfiles; fi')
    put('.bash_profile', '.dotfiles')
    put('.gitconfig', '.dotfiles')
    put('id_rsa', '.ssh')
    put('id_rsa.pub', '.ssh')
    put('bootstrap.sh', '.')

    print(yellow('우분투 환경설정을 시작합니다.'))
    run('chmod 755 bootstrap.sh')
    run('./bootstrap.sh')
    run('rm bootstrap.sh')
