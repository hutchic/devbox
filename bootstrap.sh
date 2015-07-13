#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y software-properties-common \
  && sudo apt-add-repository -y ppa:git-core/ppa \
  && sudo apt-get update \
  && sudo apt-get install -y git \
  && sudo apt-get clean autoclean \
  && sudo apt-get autoremove -y --purge \
  && sudo apt-get install -yf python curl vim strace \
    diffstat pkg-config cmake build-essential tcpdump \
    mercurial wget host dnsutils tree dos2unix zip zsh \
    language-pack-en python-pip git zsh

sudo pip install ansible
sudo pip install boto

wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker vagrant

rm .bash_logout; ln -s /vagrant/dot_files/.bash_logout .
rm .bashrc; ln -s /vagrant/dot_files/.bashrc .
ln -s /src projects

cat > /home/vagrant/.bash_login <<EOF
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
chsh -s /bin/zsh
ln -s /vagrant/dot_files/.zsh_history .
rm .zshrc; ln -s /vagrant/dot_files/.zshrc .
rm -rf .oh-my-zsh; ln -s /vagrant/dot_files/.oh-my-zsh .
sudo rm /home/vagrant/.bash_login
exit
EOF
