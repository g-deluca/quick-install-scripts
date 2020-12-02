#!/bin/bash

echo ">>> Installing curl"
sudo apt install -y curl
echo "done"


echo ">>> Installing and configuring vim"
sudo apt install -y vim
touch .vimrc
echo "set nu" >> ~/.vimrc
echo "set tabstop=4" >> ~/.vimrc
echo "set expandtab" >> ~/.vimrc
echo "done"

echo ">>> Installing and configuring git"
sudo apt install -y git

git config --global user.name "Guido De Luca"
git config --global core.editor vim
email=''
while true; do
    read -p "Hi Guido, will you use your personal email for git? [Y/n] " yn
    if [ "$yn" = "" ]; then
       yn='Y'
    fi
    case $yn in
        [Yy]* ) $email='guido.deluca7@gmail.com'
                git config --global user.email $email; break;;
        [Nn]* ) read -p "Enter email: " email;
                git config --global user.email $email;
                break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you want to generate an ssh key with this email? [Y/n] " yn
    if [ "$yn" = "" ]; then
       yn='Y'
    fi
    case $yn in
        [Yy]* ) ssh-keygen -t ed25519 -C $email;
                eval "$(ssh-agent -s)";
                ssh-add ~/.ssh/id_ed25519;
                break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo "done"

echo ">>> Installing zsh"
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Replace the zsh theme for this one ZSH_THEME=\"powerlevel10k/powerlevel10k\"."
read -p "Press a key to continue."
vim ~/.zshrc

echo ">>> Installing fonts for better UX/UI"
mkdir ~/.fonts
cd ~/.fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
cd -
echo "done"
echo "Don't forget to change your terminal's font to Meslo Regular!"

echo ">>> Installing Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
echo "done"

echo ">>> Installing nvm/node"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.1/install.sh | bash
cat <<EOF >> ~/.zshrc

# nvm config
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
EOF
source ~./zshrc
nvm install node
echo "done"

echo ">>>Installing yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install --no-install-recommends yarn
echo "done"

echo ">>>Installing mysql-client"
sudo apt install -y mysql-client
touch ~/.my.cnf
cat <<EOF >> ~/.my.cnf                                                                                                                                                                  ─╯
[mysqldump]
ssl-mode=DISABLED
column-statistics=0
EOF
echo "done"

while true; do
    read -p "Do you wanna install Peek? [Y/n] " yn
    if [ "$yn" = "" ]; then
       yn='Y'
    fi
    case $yn in
        [Yy]* ) sudo add-apt-repository ppa:peek-developers/stable;
                sudo apt update
                sudo apt install -y peek
                break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "finished installation"


