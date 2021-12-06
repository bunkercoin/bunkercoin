// Copyright (c) 2010 Satoshi Nakamoto
// Copyright (c) 2009-2014 The Bitcoin developers
// Copyright (c) 2013-2014 The Dogecoin developers
// Copyright (c)      2014 The Inutoshi developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include "chainparams.h"

#include "assert.h"
#include "core.h"
#include "protocol.h"
#include "util.h"

#include <boost/assign/list_of.hpp>

using namespace boost::assign;

//
// Main network
//

unsigned int pnSeed[] =
{
        0x81e4932d, 0xd389db43, 0x76328a2d, 0x91c69b3e
};

class CMainParams : public CChainParams {
public:
    CMainParams() {
        // The message start string is designed to be unlikely to occur in normal data.
        // The characters are rarely used upper ASCII, not valid as UTF-8, and produce
        // a large 4-byte int at any alignment.
        pchMessageStart[0] = 0xe8;
        pchMessageStart[1] = 0xc9;
        pchMessageStart[2] = 0xf0;
        pchMessageStart[3] = 0xa1;
        vAlertPubKey = ParseHex("04536744d5a57623b6602d8325383a580b1c00076a9e68fd75ff1f07240fb7408916e919cec8b8750a6e6aff08339db104106a75f976d5817490b9a1bdc2e0c727");
        nDefaultPort = 14200;
        nRPCPort = 22225;
        bnProofOfWorkLimit = CBigNum(~uint256(0) >> 20);
        nSubsidyHalvingInterval = 210000;

        // Build the genesis block. Note that the output of the genesis coinbase cannot
        // be spent as it did not originally exist in the database.
        //
        // CBlock(hash=000000000019d6, ver=1, hashPrevBlock=00000000000000, hashMerkleRoot=4a5e1e, nTime=1231006505, nBits=1d00ffff, nNonce=2083236893, vtx=1)
        //   CTransaction(hash=4a5e1e, ver=1, vin.size=1, vout.size=1, nLockTime=0)
        //     CTxIn(COutPoint(000000, -1), coinbase 04ffff001d0104455468652054696d65732030332f4a616e2f32303039204368616e63656c6c6f72206f6e206272696e6b206f66207365636f6e64206261696c6f757420666f722062616e6b73)
        //     CTxOut(nValue=50.00000000, scriptPubKey=0x5F1DF16B2B704C8A578D0B)
        //   vMerkleTree: 4a5e1e
        const char* pszTimestamp = "Times of Malta First coronavirus cases are girl and parents 7/Mar/21";
        CTransaction txNew;
        txNew.vin.resize(1);
        txNew.vout.resize(1);
        txNew.vin[0].scriptSig = CScript() << 486604799 << CBigNum(4) << vector<unsigned char>((const unsigned char*)pszTimestamp, (const unsigned char*)pszTimestamp + strlen(pszTimestamp));
        txNew.vout[0].nValue = 88 * COIN;
        txNew.vout[0].scriptPubKey = CScript() << ParseHex("04536744d5a57623b6602d8325383a580b1c00076a9e68fd75ff1f07240fb7408916e919cec8b8750a6e6aff08339db104106a75f976d5817490b9a1bdc2e0c727") << OP_CHECKSIG;
        genesis.vtx.push_back(txNew);
        genesis.hashPrevBlock = 0;
        genesis.hashMerkleRoot = genesis.BuildMerkleTree();
        genesis.nVersion = 1;
        genesis.nTime    = 1637347145;
        genesis.nBits    = 0x1e0ffff0;
        genesis.nNonce   = 467930;

        hashGenesisBlock = genesis.GetHash();
        assert(hashGenesisBlock == uint256("0x405d1f6dda6196fc4fc4f2d28a8a199a6206149556cc30ddfaa0a26c04c6c9c2"));
        assert(genesis.hashMerkleRoot == uint256("0xd80699e741a6ad2478044ad7f71642f6263b0b3d9c0af2c531ca79c7f5648fec"));

        vSeeds.push_back(CDNSSeedData("103.249.70.56", "103.249.70.56"));
        vSeeds.push_back(CDNSSeedData("140.82.1.236", "140.82.1.236"));
        vSeeds.push_back(CDNSSeedData("45.77.221.52", "45.77.221.52"));
        vSeeds.push_back(CDNSSeedData("144.202.13.184", "144.202.13.184"));
        vSeeds.push_back(CDNSSeedData("bunkercoin.xyz", "seed.bunkercoin.xyz"));
        vSeeds.push_back(CDNSSeedData("NULL", "NULL"));

        // Workaround for Boost not being quite compatible with C++11;
        std::vector<unsigned char> pka = list_of(25);
        base58Prefixes[PUBKEY_ADDRESS] = pka;
        
        std::vector<unsigned char> sca = list_of(22);
        base58Prefixes[SCRIPT_ADDRESS] = sca;
        
        std::vector<unsigned char> sk  = list_of(158);
        base58Prefixes[SECRET_KEY]     = sk;
        
        std::vector<unsigned char> epk = list_of(0x04)(0x88)(0xC4)(0x2E);
        base58Prefixes[EXT_PUBLIC_KEY] = epk;
        
        std::vector<unsigned char> esk = list_of(0x04)(0x88)(0xE1)(0xF4);
        base58Prefixes[EXT_SECRET_KEY] = esk;

        // Convert the pnSeeds array into usable address objects.
        for (unsigned int i = 0; i < ARRAYLEN(pnSeed); i++)
        {
            // It'll only connect to one or two seed nodes because once it connects,
            // it'll get a pile of addresses with newer timestamps.
            // Seed nodes are given a random 'last seen time' of between one and two
            // weeks ago.
            const uint64_t nOneWeek = 7*24*60*60;
            struct in_addr ip;
            memcpy(&ip, &pnSeed[i], sizeof(ip));
            CAddress addr(CService(ip, GetDefaultPort()));
            addr.nTime = GetTime() - GetRand(nOneWeek) - nOneWeek;
            vFixedSeeds.push_back(addr);
        }
    }

    virtual const CBlock& GenesisBlock() const { return genesis; }
    virtual Network NetworkID() const { return CChainParams::MAIN; }

    virtual const vector<CAddress>& FixedSeeds() const {
        return vFixedSeeds;
    }
protected:
    CBlock genesis;
    vector<CAddress> vFixedSeeds;
};
static CMainParams mainParams;


//
// Testnet (v3)
//
class CTestNetParams : public CMainParams {
public:
    CTestNetParams() {
        // The message start string is designed to be unlikely to occur in normal data.
        // The characters are rarely used upper ASCII, not valid as UTF-8, and produce
        // a large 4-byte int at any alignment.
        pchMessageStart[0] = 0xf2;
        pchMessageStart[1] = 0xc1;
        pchMessageStart[2] = 0xb9;
        pchMessageStart[3] = 0xd7;
        vAlertPubKey = ParseHex("04536744d5a57623b6602d8325383a580b1c00076a9e68fd75ff1f07240fb7408916e919cec8b8750a6e6aff08339db104106a75f976d5817490b9a1bdc2e0c727");
        nDefaultPort = 44556;
        nRPCPort = 44555;
        strDataDir = "testnet3";

        // Modify the testnet genesis block so the timestamp is valid for a later start.
        genesis.nTime = 1637347145;
        genesis.nNonce = 467930;
        hashGenesisBlock = genesis.GetHash();
        assert(hashGenesisBlock == uint256("0x405d1f6dda6196fc4fc4f2d28a8a199a6206149556cc30ddfaa0a26c04c6c9c2"));

        vFixedSeeds.clear();
        vSeeds.clear();
        vSeeds.push_back(CDNSSeedData("NULL", "NULL")); //Testnet DNSSeeds will probably never exist

        // Boost sucks, and should not be used. Workaround for Boost not being compatible with C++11;
        
        std::vector<unsigned char> pka = list_of(85);
        base58Prefixes[PUBKEY_ADDRESS] = pka;
        std::vector<unsigned char> sca = list_of(196);
        base58Prefixes[SCRIPT_ADDRESS] = sca;
        std::vector<unsigned char> sk  = list_of(110);
        base58Prefixes[SECRET_KEY]     = sk;
        std::vector<unsigned char> epk = list_of(0x04)(0x35)(0xD1)(0xDF);
        base58Prefixes[EXT_PUBLIC_KEY] = epk;
        std::vector<unsigned char> esk = list_of(0x04)(0x35)(0x75)(0xA4);
        base58Prefixes[EXT_SECRET_KEY] = esk;
    }
    virtual Network NetworkID() const { return CChainParams::TESTNET; }
};
static CTestNetParams testNetParams;

//
// Regression test
//
class CRegTestParams : public CTestNetParams {
public:
    CRegTestParams() {
        pchMessageStart[0] = 0xf7;
        pchMessageStart[1] = 0xb4;
        pchMessageStart[2] = 0xa6;
        pchMessageStart[3] = 0xc9;
        nSubsidyHalvingInterval = 150;
        bnProofOfWorkLimit = CBigNum(~uint256(0) >> 1);
        genesis.nTime = 1637347268;
        genesis.nBits = 0x207fffff;
        genesis.nNonce = 2;
        hashGenesisBlock = genesis.GetHash();
        nDefaultPort = 18444;
        strDataDir = "regtest";
        assert(hashGenesisBlock == uint256("0xe08a885e4191632633276ee13f8627849340187fc267610038aa9fe478bc7fab"));

        vSeeds.clear();  // Regtest mode doesn't have any DNS seeds.
    }

    virtual bool RequireRPCPassword() const { return false; }
    virtual Network NetworkID() const { return CChainParams::REGTEST; }
};
static CRegTestParams regTestParams;

static CChainParams *pCurrentParams = &mainParams;

const CChainParams &Params() {
    return *pCurrentParams;
}

void SelectParams(CChainParams::Network network) {
    switch (network) {
        case CChainParams::MAIN:
            pCurrentParams = &mainParams;
            break;
        case CChainParams::TESTNET:
            pCurrentParams = &testNetParams;
            break;
        case CChainParams::REGTEST:
            pCurrentParams = &regTestParams;
            break;
        default:
            assert(false && "Unimplemented network");
            return;
    }
}

bool SelectParamsFromCommandLine() {
    bool fRegTest = GetBoolArg("-regtest", false);
    bool fTestNet = GetBoolArg("-testnet", false);

    if (fTestNet && fRegTest) {
        return false;
    }

    if (fRegTest) {
        SelectParams(CChainParams::REGTEST);
    } else if (fTestNet) {
        SelectParams(CChainParams::TESTNET);
    } else {
        SelectParams(CChainParams::MAIN);
    }
    return true;
}
