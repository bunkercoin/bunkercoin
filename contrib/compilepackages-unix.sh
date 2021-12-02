#!/bin/bash

# Copyright (c) 2021 The Bunkercoin core developers
# Distributed under the MIT/X11 software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

# Delete old versions of libboost, OpenSSL, miniupnpc and Berkeley DB
sudo apt purge *boost* -y
sudo apt purge libssl-dev libssl1.0-dev -y
sudo apt purge miniupnpc -y
sudo apt purge libdb-dev libdb++-dev -y

# Go to home directory and make bin dirs
cd $HOME
mkdir boost-bin
mkdir ssl-bin
mkdir -p upnp-bin/include/miniupnpc
mkdir -p upnp-bin/lib
mkdir db-bin

# Get source code
wget "https://boostorg.jfrog.io/artifactory/main/release/1.65.1/source/boost_1_65_1.tar.gz"
wget "https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz"
wget "http://miniupnp.free.fr/files/miniupnpc-2.0.20161216.tar.gz"
wget "http://download.oracle.com/berkeley-db/db-5.1.29.NC.tar.gz"

# Extract source code
tar -xf boost_1_65_1.tar.gz
tar -xf openssl-1.0.2u.tar.gz
tar -xf miniupnpc-2.0.20161216.tar.gz
tar -xf db-5.1.29.NC.tar.gz

# Delete source code archives
rm -f boost_1_65_1.tar.gz openssl-1.0.2u.tar.gz miniupnpc-2.0.20161216.tar.gz db-5.1.29.NC.tar.gz

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
cd $HOME/miniupnpc-2.0.20161216
make -j`nproc`
cp libminiupnpc.a $HOME/upnp-bin/lib
cp *.h $HOME/upnp-bin/include/miniupnpc

# Build Berkeley DB
cd $HOME/db-5.1.29.NC/build_unix/
sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' ../src/dbinc/atomic.h
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$HOME/db-bin
make -j`nproc`
make install

# Install libboost
cd $HOME/boost-bin
sudo cp * -R /usr

# Install OpenSSL
cd $HOME/ssl-bin
sudo cp * -R /usr

# Install miniupnpc
cd $HOME/upnp-bin
sudo cp * -R /usr

# Install Berkeley DB
cd $HOME/db-bin 
sudo cp * -R /usr
