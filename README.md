<h1 align="center">
Bunkercoin Core [BKC, Ƀ]
<br/><br/>
<img src="https://avatars.githubusercontent.com/u/84141344?s=200&v=4" alt="Dogecoin" width="200"/>
</h1>

## [](https://github.com/bunkercoin-project/bunkercoin/tree/master#what-is-bunkercoin)What is Bunkercoin?

Bunkercoin is a cryptocurrency like Bitcoin, although it does not use SHA256 as its proof of work (POW). Taking development cues from Dogecoin and Bitcoin, Bunkercoin currently employs a simplified variant of scrypt.

## Usage 

To start your journey with Bunkercoin Core, see the [installation guide](INSTALL.md) and the [getting started](doc/getting-started.md) tutorial.

The JSON-RPC API provided by Bunkercoin Core is self-documenting and can be browsed with `bunkercoin-cli help`, while detailed information for each command can be viewed with `bunkercoin-cli help <command>`. Alternatively, see the [Bitcoin Core documentation](https://developer.bitcoin.org/reference/rpc/) - which implement a similar protocol - to get a browsable version.

##License

Bunkercoin is released under the terms of the MIT license. See  [COPYING](https://github.com/bunkercoin-project/bunkercoin/blob/master/COPYING)  for more information or see  [http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT).

## Development and contributions

Development is ongoing and the development team as well as other volunteers can freely work in their own trees and submit pull requests when features or bug fixes are ready.

## Not Frequently Asked Questions

### How much bunkercoin's can exist?

As much as your heart desires

Each subsequent block will grant a random amount of coins to encourage miners to continue to secure the network and make up for lost wallets on hard drives/lost encryption passwords/etc.

### How to get bunkercoin?

Bunkercoin uses a simplified variant of the scrypt key derivation function as its proof of work with a target time of one minute per block and difficulty readjustment after every block. The block rewards are fixed and halve every 100,000 blocks. Starting with the 600,000th block, a permanent reward of 10,000 Bunkercoin per block will be paid.

### How can I help the network?

The solid best way is to mine. You can use any guide and miner that supports scrypt coins like Dogecoin, Litecoin, etc.

### Want to know the ports? Well here is the place to be!

| Function | mainnet |
| :------- | ------: | 
| P2P      |   14200 |
| RPC      |   22555 |
