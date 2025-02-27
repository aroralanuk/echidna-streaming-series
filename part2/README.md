# Part 2: Fuzzing arithmetics and functions

## Sections

Welcome to Part 2 of the Echidna streaming series. This part has two sections:

- [ABDKMath](./abdk/Template.sol): The ABDKMath section highlights how to write simple function-level properties for arithmetic operations.
- [Staker](./staker/contracts/Template.sol): The Staker section highlights the use of an external testing methodology to test a target system. Additionally, it highlights how to use coverage reports to debug your fuzz tests.

## Slides

The slides for this part can be found [here](./Echidna_Part_2_Slides.pdf).

## Video Presentation

The video presentation for this part can be found on [YouTube](https://www.youtube.com/watch?v=9P7sqE6hILM&t=1s).

## Prerequisites (Staker)

Because Staker is a Hardhat project, before being able to fuzz it with Echidna, you have to install its dependencies.

Make sure you have npm installed.

Once you are in the Staker directory run `npm install`.

## Notes

- Property based fuzz testing, property as "truthy" values.
- How do we define expected behavior?
- Function level vs system level - stateless and isolated vs needs deep understanding
- abdkMath - signed bit, integer and fraction (1 - 63 - 64) num int128, denom - 2^64
- doesn't make sense to test the basic operations but instead follow the alegrabic properties
- assciative and inverse of add-sub
- get creative to figure out what can break
- use event emission to debug

- pre-conditions are the barriers to entry
- action - what you are testing
- post-conditions - happy vs not happy paths - (try/catch)
- optimizing fuzzer statement - break properties vs checking for overflow
-
