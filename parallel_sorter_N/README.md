About
--
This code is an attempt to generate N elements sorter in verilog, where N can be changed as a parameter.
Input will be divided into N elements, which will be sorted in parallel. 

![alt text](https://github.com/vasinwr/some_verilog/blob/master/parallel_sorter_N/design.png "Logo Title Text 1")
<br>
The code follows this design where "C" is for Comparator ( 2 inputs, 2 outputs in order max-min )

Issue
--
Unfixed bug - Only `z` is produced as a result.

Example
--
To run the example:
  1. `make`
  2. `make runsim` 

Instruction
--
make sure to have `iverilog` install on your machine.
To make: `make`
To clean: `make clean`
