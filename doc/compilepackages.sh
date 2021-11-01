#!/bin/bash

#!/bin/bash// Copyright (c) 2021 The Bunkercoin core developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

# Delete old versions of libboost and OpenSSL
sudo apt purge *boost*
sudo apt purge libssl-dev libssl1.0-dev

# Go to home directory and make bin dirs
cd $HOME
mkdir boost-bin
mkdir ssl-bin

# Get source code
wget https://boostorg.jfrog.io/artifactory/main/release/1.65.1/source/boost_1_65_1.tar.gz
wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz

# Extract source code
tar -xf boost_1_65_1.tar.gz
tar -xf openssl-1.0.2u.tar.gz

# Build libboost
cd boost_1_65_1
./bootstrap.sh --prefix=$HOME/boost-bin
./b2 install

# Build OpenSSL
cd openssl-1.0.2u
./config shared zlib --prefix=$HOME/ssl-bin
make -j`nproc`
make install

# Install libboost
cd $HOME/boost-bin
sudo cp * -R /usr

# Install OpenSSL
cd $HOME/ssl-bin
sudo cp * -R /usr
