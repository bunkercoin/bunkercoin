## HUGE UPDATE
Major Release! Bunkercoin Core 1.15.0 introduces AuxPOW at block 100,000 and a softfork at block 80,000.
Please upgrade as soon as possible! ALL users MUST upgrade to Bunkercoin Core 1.15.0
before block 80,000 if you want to mine and 100,000 if you want to send and receive coins on the network.

AuxPOW (also known as Merged Mining) will allow you to mine AuxPOW Coins while mining Bunkercoin.
You could be mining Bunkercoin and get some Dogecoin or Dingocoin in the process.
Upgrading

Backup your wallet.dat before you upgrade!

A full reindex is required as part of the upgrade to 1.15, and this will
typically take around an 30 minutes to complete. If you are
running the GUI client you will be prompted to reindex
when first running the software, while if you use "bunkercoind" you must run
it the first time with the "-reindex" command line option.
Downgrading

Downgrading is not possible.
AuxPOW

Since AuxPOW will be enabled on block 100,000 all RPC Commands
for using AuxPOW will fail and AuxPOW blocks will be rejected.

AuxPoW benefits Bunkercoin in two ways; firstly, the effective hashrate of the coin is
increased by these additional miners, making it harder to perform a 51% attack against
the coin, and secondly it reduces conflict for resources (Scrypt miners), demotivating
multipools from switching between Bunkercoin and other Scrypt coins.
Other changes

There is alot of changes, if you want to know all of them you will have to look at
changed between Dogecoin Core 1.7 till Dogecoin 1.14.5
