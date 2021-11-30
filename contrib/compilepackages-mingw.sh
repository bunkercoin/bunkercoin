#!/bin/bash

# Copyright (c) 2021 The Bunkercoin core developers
# Distributed under the MIT/X11 software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

# This file can be used to cross-compile packages for Windows on Linux
# to see how to compile packages for Windows ON Windows check out compilepackges-mingw.bat

# Delete old versions of libboost, OpenSSL, miniupnpc and Berkeley DB
sudo apt purge *boost* -y
sudo apt purge libssl-dev libssl1.0-dev -y
sudo apt purge miniupnpc -y
sudo apt purge libdb-dev libdb++-dev -y

# Go to home directory and make bin dirs
cd $HOME
mkdir -p mingw-bin/include/miniupnpc
mkdir -p mingw-bin/lib

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
./Configure mingw64 --cross-compile-prefix=x86_64-w64-mingw32- --prefix=$HOME/mingw-bin
sed -i '64s/.*/$| = 1;/gi' crypto/perlasm/x86_64-xlate.pl
make -j`nproc`
make install

# Build miniupnpc
cd $HOME/miniupnpc-2.0.20161216
wget "https://raw.githubusercontent.com/bunkercoin-project/bunkercoin/1.0-dev/contrib/patch_miniupnpc_cross_windows.patch"
patch < patch_miniupnpc_cross_windows.patch
make -j`nproc` -f Makefile.mingw
cp libminiupnpc.a $HOME/mingw-bin/lib
cp *.h $HOME/mingw-bin/include/miniupnpc

# Build Berkeley DB
cd $HOME/db-5.1.29.NC/build_unix/
sed -i "s/__atomic_compare_exchange/__atomic_compare_exchange_db/g" ../src/dbinc/atomic.h
sed -i "s/WinIoCtl.h/winioctl.h/g" ../src/dbinc/win_db.h
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$HOME/mingw-bin --host=x86_64-w64-mingw32 --enable-mingw --disable-replication
make -j`nproc`
make install

# Build libboost
cd $HOME/boost_1_55_0
./bootstrap.sh
sed -i "s/using gcc ;/using gcc : x86_64 : x86_64-w64-mingw32-g++ ;/g" project-config.jam
./bjam install toolset=gcc-mingw --prefix=$HOME/mingw-bin target-os=windows variant=release