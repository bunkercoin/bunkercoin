#!/bin/bash

# Copyright (c) 2021 The Bunkercoin core developers
# Distributed under the MIT/X11 software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

# This file can be used to cross-compile packages for Windows on Linux
# to see how to compile packages for Windows ON Windows check out compilepackges-mingw.bat

# Delete old versions of libboost, OpenSSL, miniupnpc, Berkeley DB and QT
sudo apt purge *boost* \
    libssl-dev libssl1.0-dev \
    miniupnpc \
    libdb-dev libdb++-dev \
    libqt4-dev -y

# Go to home directory and make bin dirs
cd $HOME
mkdir -p mingw-bin/include/miniupnpc
mkdir -p mingw-bin/lib

# Get source code
wget "https://www.openssl.org/source/old/1.0.2/openssl-1.0.2u.tar.gz" \
    "http://miniupnp.free.fr/files/miniupnpc-2.0.20161216.tar.gz" \
    "http://download.oracle.com/berkeley-db/db-5.1.29.NC.tar.gz" \
    "https://boostorg.jfrog.io/artifactory/main/release/1.65.1/source/boost_1_65_1.tar.gz" \
#    "https://download.qt.io/archive/qt/4.8/4.8.5/qt-everywhere-opensource-src-4.8.5.tar.gz" \
    "https://github.com/protocolbuffers/protobuf/archive/refs/heads/master.tar.gz"

# Extract source code
tar -xf openssl-1.0.2u.tar.gz
tar -xf miniupnpc-2.0.20161216.tar.gz
tar -xf db-5.1.29.NC.tar.gz
tar -xf boost_1_65_1.tar.gz
#tar -xf qt-everywhere-opensource-src-4.8.5.tar.gz
tar -xf master.tar.gz

rm -f openssl-1.0.2u.tar.gz \
    miniupnpc-2.0.20161216.tar.gz \
    db-5.1.29.NC.tar.gz \
    boost_1_55_0.tar.gz \
#    qt-everywhere-opensource-src-4.8.5.tar.gz \
    master.tar.gz

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
cd $HOME/boost_1_65_1
./bootstrap.sh
sed -i "s/using gcc ;/using gcc : x86_64 : x86_64-w64-mingw32-g++ ;/g" project-config.jam
./bjam install toolset=gcc-mingw --prefix=$HOME/mingw-bin variant=release address-model=64 architecture=x86 target-os=windows abi=ms binary-format=pe
wget "https://raw.githubusercontent.com/bunkercoin-project/bunkercoin/master/contrib/boost_thread_windows/libboost_thread.a"
mv libboost_thread.a $HOME/mingw-bin/lib

# Build QT
#cd $HOME/qt-everywhere-opensource-src-4.8.5
#./configure -release -silent -prefix $HOME/qt \
#    -no-opengl -no-dbus -no-freetype -xplatform win32-g++ -device-option CROSS_COMPILE="x86_64-w64-mingw32-" -pch \
#    -no-feature-xml -no-feature-wizard -no-feature-vnc -no-feature-undoview -no-feature-undostack -no-feature-undogroup \
#    -no-feature-undocommand -no-feature-udpsocket -no-feature-topleveldomain -no-feature-textodfwriter \
#    -no-feature-textmarkdownwriter -no-feature-textbrowser -no-feature-syntaxhighlighter -no-feature-statemachine \
#    -no-feature-sqlmodel -no-feature-sql -no-feature-socks5 -no-feature-sessionmanager -no-feature-printpreviewwidget \
#    -no-feature-printpreviewdialog -no-feature-printdialog -no-feature-pdf -no-feature-networkproxy \
#    -no-feature-networkdiskcache -no-feature-lcdnumber -no-feature-keysequenceedit -no-feature-image_heuristic_mask \
#    -no-feature-http -no-feature-ftp -no-feature-fontcombobox -no-feature-dial -no-feature-concurrent \
#    -no-feature-commandlineparser -no-feature-colordialog -no-feature-bearermanagement -no-cups -no-egl -no-gif \
#    -no-glib -no-icu -no-iconv -no-libjpeg -no-openssl -no-openvg -no-reduce-relocations -no-sql-db2 -no-sql-ibase \
#    -no-sql-oci -no-sql-tds -no-sql-mysql -no-sql-odbc -no-sql-psql -no-sql-sqlite -no-sql-sqlite2 -no-system-proxies \
#    -nomake examples -nomake tests -nomake tools -opensource -qt-libpng -qt-zlib -static -confirm-license -c++std c++17
#make -j`nproc`

# Build protobuf
cd $HOME/protobuf-master
./autogen.sh
./configure --prefix=$HOME/mingw-bin --host=x86_64-w64-mingw32 --enable-static --enable-shared=no
make -j`nproc`
make install

# Install packages
cd $HOME/mingw-bin
sudo cp * -R /usr/x86_64-w64-mingw32
