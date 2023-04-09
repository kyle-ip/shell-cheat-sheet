#!/bin/bash

# Update system package list and upgrade
function update_and_upgrade() {
    echo "Replacing APT mirror source with Alibaba Cloud mirror source..."
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo bash -c "echo 'deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs) main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs) main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -cs)-security main restricted universe multiverse
' > /etc/apt/sources.list"
    
    echo "Updating system package list and upgrading..."
    sudo apt update
    sudo apt upgrade -y
}

# Install common libraries and packages
function install_common_tools() {
    echo "Installing common libraries and packages..."
    sudo apt install -y htop iotop iftop git curl wget vim zsh
    
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# Install programming languages and package managers
function install_languages() {
    echo "Installing programming languages and package managers..."

    # Install Java
    echo "Installing Java..."
    sudo apt install -y openjdk-19-jdk
    sudo apt install -y gradle maven

    # Install Go
    echo "Installing Go..."
    sudo apt install -y golang

    # Install Python
    echo "Installing Python..."
    sudo apt install -y python3 python3-pip

    echo "Installing Conda..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
    rm Miniconda3-latest-Linux-x86_64.sh
    echo "export PATH=\"\$HOME/miniconda3/bin:\$PATH\"" >> $HOME/.bashrc
    source $HOME/.bashrc
    conda init

    # Install Node.js and npm
    echo "Installing Node.js and npm..."
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt install -y nodejs

    # Install TypeScript
    echo "Installing TypeScript..."
    sudo npm install -g typescript

    # Install C/C++
    echo "Installing C/C++..."
    sudo apt install -y build-essential
    sudo pip install conan

    # Install Rust
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

# Install Docker and Docker Compose
function install_docker() {
    echo "Installing Docker and Docker Compose..."

    # Install Docker
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sh

    # Add the current user to the docker group
    echo "Adding the current user to the docker group..."
    sudo usermod -aG docker $USER

    # Install Docker Compose
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

# Main function
function main() {
    update_and_upgrade
    install_common_tools
    install_languages
    install_docker
    echo "Development environment setup complete!"
}

main
