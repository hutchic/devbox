#!/bin/bash

sudo usermod -a -G btsync `whoami`
mkdir -p /var/lib/btsync/devbox/
if [ ! -d `pwd`/devbox ]; then
    ln -s /var/lib/btsync/devbox `pwd`/devbox
fi

if [ ! -d `pwd`/.atom ]; then
    ln -s `pwd`/devbox/.atom `pwd`/.atom
fi

if ! [ -L .zsh_history ]; then
    rm `pwd`/.zsh_history
    ln -s `pwd`/devbox/.zsh_history `pwd`/.zsh_history
fi

if ! [ -L .ssh ]; then
    rm -rf `pwd`/.ssh
    ln -s `pwd`/devbox/.ssh `pwd`/.ssh
fi

sudo apt-key add ~/devbox/repo.keys
sudo cp -R ~/devbox/sources/* /etc/apt/
sudo apt-get update
sudo apt-get install dselect
sudo dselect update
sudo dpkg --set-selections < ~/devbox/Package.list
sudo apt-get dselect-upgrade -y

sudo touch /etc/cron.hourly/export_packages
sudo cat > /etc/cron.hourly/export_packages <<EOF
#!/bin/bash

sudo dpkg --get-selections > /var/lib/btsync/devbox/Package.list
sudo mkdir -p /var/lib/btsync/devbox/sources
sudo cp -R /etc/apt/sources.list* /var/lib/btsync/devbox/sources/
sudo apt-key exportall > /var/lib/btsync/devbox/repo.keys

sudo chmod -R 775 /var/lib/btsync/devbox/sources
sudo chmod -R 775 /var/lib/btsync/devbox/repo.keys
sudo chmod -R 775 /var/lib/btsync/devbox/Package.list
EOF

sudo chmod +x /etc/cron.hourly/export_packages
sudo chmod -R 775 /var/lib/btsync
