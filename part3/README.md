
# Part 3: Fuzzing Uniswap V2 (Part 1)

## Sections

Welcome to Part 3 of the Echidna streaming series. This part has two sections:

- [Uni-V2](./contracts/uni-v2/): This directory contains the logic of the Uniswap V2 Codebase. In the workshop we mainly examined the pair contracts, however feel free to investigate the router (part 4 will cover it more in detail).
- [Crytic](./contracts/crytic/): This directory shows how to use Echidna on the Uniswap V2 Core contracts. You can use the setup as a template, try making your own tests!

## Slides

The slides for this part can be found [here](./Echidna-Streaming-Session-Part-3.pdf).

## Video Presentation

The video presentation for this part can be found on [YouTube](https://www.youtube.com/watch?v=n0RaKKVTGvA). For the updates to `testSwap()`, please look at the Youtube link in [part4](../part4/).

## Prerequisites

Because Uniswap V2 is a Hardhat project, before being able to fuzz it with Echidna, you have to install its dependencies.

Run the following commands:

```
git clone git@github.com:crytic/echidna-streaming-series
cd part3
npm install
echidna-test . --contract EchidnaTest --config contracts/crytic/config.yaml
```

## Notes

- traditional fuzzing is just looking for crashes, for smart contracts we need to look for assertion fails
- identify your invariant first in high level terms
- pre-conditions - scope for input space
- coverage mode enabled - what lines in the code did we hit
- internal as inheritance and easy to setup but only viable to single entry point contracts
- external as composition and middleman taking actions
- Q. Does each subsequent Echidna run improve the future runs? Every time I run Echidna, it says that it loads some transactions from the corpus directory. What does it mean?
- A. store the coverage in croppus and use prev to build bew transaction - reuse the sequences to hit the same issues first
- mint function check balance vs reserves for calculating what the user deposited
- mint in constructor - random values not allowed, cached for optimization purposes
- mint a fixed amount in contract constructor
