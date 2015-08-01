#!/bin/bash

sudo usermod -a -G btsync `whoami`
sudo chmod -R 775 /var/lib/btsync
mkdir -p /var/lib/btsync/devbox/
if [ ! -d `pwd`/devbox ]
  then
    ln -s /var/lib/btsync/devbox `pwd`/devbox
fi

if [ ! -f `pwd`/devbox/.zsh_history ]; then
    mv .zsh_history devbox/
fi
if ! [ -L .zsh_history ]; then
    rm `pwd`/.zsh_history
    ln -s `pwd`/devbox/.zsh_history `pwd`/.zsh_history
fi

if [ ! -d `pwd`/devbox/.ssh ]; then
    mv `pwd`/.ssh devbox/
fi
if ! [ -L .ssh ]; then
    rm `pwd`/.ssh
    ln -s `pwd`/devbox/.ssh `pwd`/.ssh
fi

if [ ! -d `pwd`/devbox/.mozilla ]; then
    mv `pwd`/.mozilla `pwd`/devbox/
    ln -s `pwd`/devbox/.mozilla .
fi

if [ ! -d `pwd`/devbox/google-chrome ]; then
    if [ ! -d `pwd`/.config/google-chrome ]; then
        mkdir -p `pwd`/.config/google-chrome
    fi
    mv `pwd`/.config/google-chrome `pwd`/devbox/
    ln -s `pwd`/devbox/google-chrome `pwd`/.config/
fi
