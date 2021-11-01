# Bunkercoin Core [BKC, Ƀ]

## What is Bunkercoin?
Bunkercoin is a cryptocurrency like Bitcoin, although it does not use SHA256 as its proof of work (POW). Taking development cues from Dogecoin and Bitcoin, Bunkercoin currently employs a simplified variant of scrypt.

## License
Bunkercoin is released under the terms of the MIT license. See [COPYING](COPYING)
for more information or see http://opensource.org/licenses/MIT.

## Development and contributions
Development is ongoing and the development team as well as other volunteers can freely work in their own trees and submit pull requests when features or bug fixes are ready.

## Not Frequently Asked Questions

### How much bunkercoin's can exist?
Approximately 100,000,000,000 coins.
Each subsequent block will grant a random ammount of coins to encourage miners to continue to secure the network and make up for lost wallets on hard drives/lost encryption passwords/etc.

### How to get bunkercoin?
Bunkercoin uses a simplified variant of the scrypt key derivation function as its proof of work with a target time of one minute per block and difficulty readjustment after every block. The block rewards are fixed and halve every 100,000 blocks. Starting with the 600,000th block, a permanent reward of 10,000 Bunkercoin per block will be paid. 

The current block reward schedule:

1–99,000: 0–1,000,000 Bunkercoin 

100,000–144,999: 0–500,000 Bunkercoin

145,000–199,999: 250,000 Bunkercoin

200,000–299,999: 125,000 Bunkercoin

300,000–399,999: 62,500 Bunkercoin

400,000–499,999: 31,250 Bunkercoin

500,000–599,999: 15,625 Bunkercoin

600,000+: 10,000 Bunkercoin

### Want to compile bunkercoind/bunkercoin-cli/bunkercoin-qt?

  The following are developer notes on how to build Bunkercoin on your native platform. They are not complete guides, but include notes on the necessary libraries, compile flags, etc.

  - [OSX Build Notes](doc/build-osx.md)
  - [Unix Build Notes](doc/build-unix.md)
  - [Windows Build Notes](doc/build-msw.md)

### How can I help the network?

The solid best way is to mine. Currently we recommend mining with a CPU to keep the network nice and usable. You can use any guide and miner that supports scrypt coins like Dogecoin, Litecoin, etc.

### Want to know the ports? Well here is the place to be!
RPC 22225
P2P 14200 
