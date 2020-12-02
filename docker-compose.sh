#!/bin/bash

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "You may want to enable the autocompletion feature in the .zshrc file."
echo "Just add the following: plugins = (... docker docker-compose ...)"
read -p "Press a key to continue." key
vim ~/.zshrc
source ~/.zshrc

# Post installation
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
