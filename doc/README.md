Bunkercoin 1.0.0
=====================

* Copyright (c) 2009-2014 Bitcoin Developers
* Copyright (c) 2011-2013 Litecoin Developers
* Copyright (c) 2013-2014 Dogecoin Developers


Setup
---------------------
[Bunkercoin Core](http://bunkercoin.com/en/download) is the original Bunkercoin client and it builds the backbone of the network. However, it downloads and stores the entire history of Bunkercoin transactions (which is currently several GBs); depending on the speed of your computer and network connection, the synchronization process can take anywhere from a few hours to a day or more. Thankfully you only have to do this once.

Running
---------------------
The following are some helpful notes on how to run Bunkercoin on your native platform. 

### Unix

You need the Qt4 run-time libraries to run Bunkercoin-Qt. On Debian or Ubuntu:

	sudo apt-get install libqtgui4

Unpack the files into a directory and run:

- bin/32/bunkercoin-qt (GUI, 32-bit) or bin/32/bunkercoind (headless, 32-bit)
- bin/64/bunkercoin-qt (GUI, 64-bit) or bin/64/bunkercoind (headless, 64-bit)



### Windows

Unpack the files into a directory, and then run bunkercoin-qt.exe.

### OSX

Drag Bunkercoin-Qt to your applications folder, and then run Bunkercoin-Qt.

### Need Help?


For help and more information.
* Ask for help on the [/r/dogeducation subreddit](http://reddit.com/r/bunkercoin).

Building
---------------------
The following are developer notes on how to build Bunkercoin on your native platform. They are not complete guides, but include notes on the necessary libraries, compile flags, etc.

- [OSX Build Notes](build-osx.md)
- [Unix Build Notes](build-unix.md)
- [Windows Build Notes](build-msw.md)

Development
---------------------
The Bunkercoin repo's [root README](https://github.com/bunkercoin/bunkercoin/blob/master/README.md) contains relevant information on the development process and automated testing.

- [Coding Guidelines](coding.md)
- [Release Notes](release-notes.md)
- [Release Process](release-process.md)
- [Source Code Documentation (External Link)](https://dev.visucore.com/bitcoin/doxygen/)
- [Translation Process](translation_process.md)
- [Unit Tests](unit-tests.md)

### Miscellaneous
- [Assets Attribution](assets-attribution.md)
- [Files](files.md)
- [Tor Support](tor.md)

License
---------------------
Distributed under the [MIT/X11 software license](http://www.opensource.org/licenses/mit-license.php).
This product includes software developed by the OpenSSL Project for use in the [OpenSSL Toolkit](http://www.openssl.org/). This product includes
cryptographic software written by Eric Young ([eay@cryptsoft.com](mailto:eay@cryptsoft.com)), and UPnP software written by Thomas Bernard.
