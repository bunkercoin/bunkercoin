### Seeds ###

Utility to generate the pnSeed[] array that is compiled into the client
(see [src/chainparams.cpp](/src/chainparams.cpp)).

The input to makeseeds.py is assumed to be approximately sorted from most-reliable to least-reliable,
with IP:port first on each line (lines that don't match IPv4:port are ignored).

We also have makeseeds.perl which was used to encode the first few nodes
