#!/usr/bin/env bash
set -e

VIMRC_URL="https://raw.githubusercontent.com/pavan-tx9/vimrc/main/.vimrc"

install_vim() {
    echo "Installing vim..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get update -qq
        sudo apt-get install -y vim-gtk3 2>/dev/null || sudo apt-get install -y vim
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y vim-enhanced
    elif command -v yum &>/dev/null; then
        sudo yum install -y vim-enhanced
    elif command -v pacman &>/dev/null; then
        sudo pacman -Sy --noconfirm gvim 2>/dev/null || sudo pacman -Sy --noconfirm vim
    elif command -v zypper &>/dev/null; then
        sudo zypper install -y vim
    elif command -v apk &>/dev/null; then
        apk add --no-cache vim
    elif command -v brew &>/dev/null; then
        brew install vim
    else
        echo "Could not detect package manager. Install vim manually."
        exit 1
    fi
}

command -v vim &>/dev/null || install_vim

curl -fLo ~/.vimrc "$VIMRC_URL"
echo "Done. Run 'vim' — plugins will auto-install on first launch."
