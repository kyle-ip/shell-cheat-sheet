#! /bin/sh

# dependencies
mv /etc/yum.repos.d /etc/yum.repos.d.bak
mkdir /etc/yum.repos.d
wget -c -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
sed -i 's/failovermethod=priority//g' /etc/yum.repos.d/CentOS-Base.repo
yum -y install epel-release
yum clean all && yum makecache
yum -y update && yum -y upgrade
yum-config-manager \
    --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum -y remove git*
yum -y --allowerasing install yum-utils \
    device-mapper-persistent-data \
    net-tools lvm2 net-tools autoconf \
    vim wget openssh make automake cmake \
    libtool gcc gcc-c++ gdb glibc-headers \
    zlib-devel telnet ctags libcurl-devel \
    jq expat-devel openssl-devel git-lfs \
    docker-ce docker-ce-cli containerd.io \
    perl-CPAN lrzsz python3 python3-pip 

# NeoVim & SpaceVim
pip3 install pynvim
yum -y install neovim
# tee -a $HOME/.bashrc <<'EOF'
# # Configure for nvim
# export EDITOR=nvim
# alias vi="nvim"
# EOF
cd /tmp
wget https://marmotedu-1254073058.cos.ap-beijing.myqcloud.com/tools/marmotVim.tar.gz
tar -xvzf marmotVim.tar.gz
cd marmotVim
./marmotVimCtl install
# cd /tmp
# wget https://marmotedu-1254073058.cos.ap-beijing.myqcloud.com/tools/gotools-for-spacevim.tgz
# mkdir -p $GOPATH/bin
# tar -xvzf gotools-for-spacevim.tgz -C $GOPATH/bin


# Git
cd /tmp
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.30.2.tar.gz
tar -xvzf git-2.30.2.tar.gz
cd git-2.30.2 && ./configure && make && make install
git --version
git config --global user.name "yipwinghong"
git config --global user.email "yipwinghong@outlook.com"
git config --global credential.helper store    
git config --global core.longpaths true
git config --global core.quotepath off

# Go
# wget https://golang.google.cn/dl/go1.17.2.linux-amd64.tar.gz -O /tmp/go1.17.2.linux-amd64.tar.gz
# mkdir -p $HOME/go
# tar -xvzf /tmp/go1.17.2.linux-amd64.tar.gz -C $HOME/go
# mv $HOME/go/go $HOME/go/go1.17.2
# tee -a $HOME/.bashrc <<'EOF'
# # Go envs
# export GOVERSION=go1.17.2
# export GO_INSTALL_DIR=$HOME/go
# export GOROOT=$GO_INSTALL_DIR/$GOVERSION
# export GOPATH=$WORKSPACE/golang
# export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
# export GO111MODULE="on"
# export GOPROXY=https://goproxy.cn,direct
# export GOPRIVATE=
# export GOSUMDB=off
# EOF

# ProtoBuf

cd /tmp/
git clone --depth=1 https://github.com/protocolbuffers/protobuf
cd protobuf
./autogen.sh
./configure
make
sudo make install
protoc --version
# go get -u github.com/golang/protobuf/protoc-gen-go
# export LINUX_PASSWORD='iam59!z$'
