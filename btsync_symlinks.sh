#!/bin/bash

sudo usermod -a -G btsync `whoami`
sudo chmod -R 775 /var/lib/btsync
mkdir -p /var/lib/btsync/devbox/
if [ ! -d `pwd`/devbox ]; then
    ln -s /var/lib/btsync/devbox `pwd`/devbox
fi

if ! [ -L .zsh_history ]; then
    rm `pwd`/.zsh_history
    ln -s `pwd`/devbox/.zsh_history `pwd`/.zsh_history
fi

if ! [ -L .ssh ]; then
    rm -rf `pwd`/.ssh
    ln -s `pwd`/devbox/.ssh `pwd`/.ssh
fi
