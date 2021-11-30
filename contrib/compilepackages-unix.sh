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
mkdir -p unix-bin/include/miniupnpc
mkdir -p unix-bin/lib

# Get source code
wget "https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz"
wget "http://miniupnp.free.fr/files/miniupnpc-2.0.20161216.tar.gz"
wget "http://download.oracle.com/berkeley-db/db-5.1.29.NC.tar.gz"
wget "https://deac-ams.dl.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.gz"

# Extract source code
tar -xf openssl-1.0.2u.tar.gz
tar -xf miniupnpc-2.0.20161216.tar.gz
tar -xf db-5.1.29.NC.tar.gz
tar -xf boost_1_55_0.tar.gz

# Build OpenSSL
cd $HOME/openssl-1.0.2u
./config --prefix=/usr
make -j`nproc`
sudo make install

# Build miniupnpc
cd $HOME/miniupnpc-2.0.20161216
make -j`nproc`
cp libminiupnpc.a libminiupnpc.so $HOME/unix-bin/lib
cp *.h $HOME/unix-bin/include/miniupnpc

# Build Berkeley DB
cd $HOME/db-5.1.29.NC/build_unix/
sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' ../src/dbinc/atomic.h
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$HOME/unix-bin
make -j`nproc`
make install

# Build libboost
cd $HOME/boost_1_55_0
./bootstrap.sh --prefix=$HOME/unix-bin
./b2 install