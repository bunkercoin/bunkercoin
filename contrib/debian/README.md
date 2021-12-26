
Debian
====================
This directory contains files used to package bunkercoind/bunkercoin-qt
for Debian-based Linux systems. If you compile bunkercoind/bunkercoin-qt yourself, there are some useful files here.

## bunkercoin: URI support ##


bunkercoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install bunkercoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your bunkercoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/bunkercoin128.png` to `/usr/share/pixmaps`

bunkercoin-qt.protocol (KDE)

