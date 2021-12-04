#!/bin/bash

# Copyright (c) 2021 The Bunkercoin core developers
# Distributed under the MIT/X11 software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

# Delete old versions of libboost, OpenSSL, miniupnpc, Berkeley DB and QT
sudo apt purge *boost* \
    libssl-dev libssl1.0-dev \
    miniupnpc \
    libdb-dev libdb++-dev \
    libqt4-dev -y

# Go to home directory and make bin dirs
cd $home
mkdir ssl-bin
mkdir -p unix-bin/include/miniupnpc
mkdir -p unix-bin/lib

# Get source code
wget "https://boostorg.jfrog.io/artifactory/main/release/1.65.1/source/boost_1_65_1.tar.gz" \
    "https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz" \
    "http://miniupnp.free.fr/files/miniupnpc-2.0.20161216.tar.gz" \
    "http://download.oracle.com/berkeley-db/db-5.1.29.NC.tar.gz" \
    "https://download.qt.io/archive/qt/4.8/4.8.5/qt-everywhere-opensource-src-4.8.5.tar.gz"

# Extract source code
tar -xf boost_1_65_1.tar.gz
tar -xf openssl-1.0.2u.tar.gz
tar -xf miniupnpc-2.0.20161216.tar.gz
tar -xf db-5.1.29.NC.tar.gz
tar -xf qt-everywhere-opensource-src-4.8.5.tar.gz

# Delete source code archives
rm -f boost_1_65_1.tar.gz \
    openssl-1.0.2u.tar.gz \
    miniupnpc-2.0.20161216.tar.gz \
    db-5.1.29.NC.tar.gz \
    qt-everywhere-opensource-src-4.8.5.tar.gz

# Build OpenSSL
cd $HOME/openssl-1.0.2u
./config no-shared --prefix=$HOME/ssl-bin
make -j`nproc`
make install

# Build miniupnpc
cd $HOME/miniupnpc-2.0.20161216
make -j`nproc`
cp libminiupnpc.a $HOME/unix-bin/lib
cp *.h $HOME/unix-bin/include/miniupnpc

# Build Berkeley DB
cd $HOME/db-5.1.29.NC/build_unix/
sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' ../src/dbinc/atomic.h
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$HOME/unix-bin
make -j`nproc`
make install

# Build libboost
cd $HOME/boost_1_65_1
./bootstrap.sh
./bjam install --prefix=$HOME/unix-bin variant=release address-model=64 architecture=x86

# Build QT
cd $HOME/qt-everywhere-opensource-src-4.8.5

# Install OpenSSL
cd $HOME/ssl-bin
sudo cp * -R /usr

# Install the built files
cd $HOME/unix-bin
rm -f *.so*
sudo cp * -R /usr
