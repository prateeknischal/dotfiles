#!/bin/bash
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt update

# change caps to escape for vim
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"

# get pip3
sudo apt install python3-pip

# Install all lsp
python3 -m pip install "python-lsp-server[all]"
sudo apt install -y clangd nodejs

wget https://github.com/sumneko/lua-language-server/releases/download/3.2.2/lua-language-server-3.2.2-linux-x64.tar.gz
mkdir -p ~/.local/bin/sumneko_lua
tar -C ~/.local/bin/sumneko_lua -xf lua-language-server-3.2.2-linux-x64.tar.gz

sudo node install -g eslint bash-language-server
