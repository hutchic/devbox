#!/bin/bash

if [ ! -d /var/lib/btsync/sync ]; then
    echo "sync directory not found /var/lib/btsync/sync"
    exit
fi

sudo usermod -a -G btsync `whoami`
if [ ! -d `pwd`/sync ]; then
    ln -s /var/lib/btsync/sync `pwd`/sync
fi

if [ ! -d `pwd`/.atom ]; then
    ln -s `pwd`/sync/.atom `pwd`/.atom
fi

if ! [ -L .zsh_history ]; then
    rm `pwd`/.zsh_history
    ln -s `pwd`/sync/.zsh_history `pwd`/.zsh_history
fi

if ! [ -L .ssh ]; then
    rm -rf `pwd`/.ssh
    ln -s `pwd`/sync/.ssh `pwd`/.ssh
fi

sudo apt-key add ~/sync/repo.keys
sudo cp -R ~/sync/sources/* /etc/apt/
sudo apt-get update
sudo apt-get install dselect
sudo dselect update
sudo dpkg --set-selections < ~/sync/Package.list
sudo apt-get dselect-upgrade -y

sudo touch /etc/cron.hourly/export_packages
sudo cat > /etc/cron.hourly/export_packages <<EOF
#!/bin/bash

sudo dpkg --get-selections > /var/lib/btsync/sync/Package.list
sudo mkdir -p /var/lib/btsync/sync/sources
sudo cp -R /etc/apt/sources.list* /var/lib/btsync/sync/sources/
sudo apt-key exportall > /var/lib/btsync/sync/repo.keys

sudo chmod -R 775 /var/lib/btsync/sync/sources
sudo chmod -R 775 /var/lib/btsync/sync/repo.keys
sudo chmod -R 775 /var/lib/btsync/sync/Package.list
EOF

sudo chmod +x /etc/cron.hourly/export_packages
