#!/bin/bash

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:git-core/ppa
sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
sudo add-apt-repository -y ppa:videolan/stable-daily
sudo add-apt-repository -y ppa:gnome3-team/gnome3
sudo add-apt-repository -y ppa:webupd8team/java
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

sudo apt-get install -yf python curl vim zip zsh language-pack-en python-pip git zsh

echo "Cleaning Up"
sudo apt-get -f install
sudo apt-get -y autoremove --purge
sudo apt-get -y autoclean
sudo apt-get -y clean

sudo pip install ansible
sudo pip install boto

wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker vagrant

ln -s /src projects

cat > /home/vagrant/.bash_login <<EOF
sh -c $(curl -fsSL http://debian.yeasoft.net/add-btsync14-repository.sh)
sudo apt-get install -y btsync
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
chsh -s /bin/zsh
rm .zshrc || true; ln -s /vagrant/dot_files/.zshrc .
rm -rf .oh-my-zsh || true; ln -s /vagrant/dot_files/.oh-my-zsh .
sudo rm /home/vagrant/.bash_login
exit
EOF
chmod +x /home/vagrant/.bash_login
sudo chown -R vagrant:vagrant /home/vagrant
sudo pkill -u vagrant
