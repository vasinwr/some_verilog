About
--
This adder takes sequencial inputs and outputs the sum of the most recent N inputs given.

     -------         -----------         -------------------               ----------------
   /         \     /             \     /                     \           /                  \ 
--            + --                + --                        + ... + --                     + --
   \         /     \             /     \                     /           \                  /
     -- R --         -- R - R --         -- R - R - R - R --               -- R - ... - R -
1st block: 2^1 regs   2nd: 2^2 regs         3rd: 2^3 regs               Nth block : 2^N registers

Example
--
To run the example:
  1. `make`
  2. `make runsim` 

