#!/bin/bash

# Copyright (c) 2021 The Bunkercoin core developers
# Distributed under the MIT/X11 software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

# Delete old versions of libboost, OpenSSL and miniupnpc
sudo apt purge *boost* -y
sudo apt purge libssl-dev libssl1.0-dev -y
sudo apt purge miniupnpc -y

# Go to home directory and make bin dirs
cd $HOME
mkdir boost-bin
mkdir ssl-bin
mkdir -p upnp-bin/include/miniupnpc
mkdir -p upnp-bin/lib

# Get source code
wget https://boostorg.jfrog.io/artifactory/main/release/1.65.1/source/boost_1_65_1.tar.gz
wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz
wget http://miniupnp.free.fr/files/download.php?file=miniupnpd-2.0.20180503.tar.gz

# Extract source code
tar -xf boost_1_65_1.tar.gz
tar -xf openssl-1.0.2u.tar.gz
tar -xf miniupnpd-2.0.20180503.tar.gz

# Build libboost
cd $HOME/boost_1_65_1
./bootstrap.sh --prefix=$HOME/boost-bin
./b2 install

# Build OpenSSL
cd $HOME/openssl-1.0.2u
./config shared zlib --prefix=$HOME/ssl-bin
make -j`nproc`
make install

# Build miniupnpc
cd $HOME/miniupnpd-2.0.20180503
make -j`nproc`
cp libminiupnpc.a $HOME/upnp-bin/lib
cp *.h $HOME/upnp-bin/include/miniupnpc

# Install libboost
cd $HOME/boost-bin
sudo cp * -R /usr

# Install OpenSSL
cd $HOME/ssl-bin
sudo cp * -R /usr

# Install miniupnpc
cd $HOME/upnp-bin
sudo cp * -R /usr
