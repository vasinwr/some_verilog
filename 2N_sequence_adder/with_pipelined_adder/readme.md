About
--
This adder takes sequencial inputs and outputs the sum of the most recent N inputs given. 
This is similar to the "with normal adder" design except that it uses an adder which contain registers and the number of registers can be changed via the parameter in the test bench file.

![alt text](https://github.com/vasinwr/some_verilog/blob/master/2N_sequence_adder/with_normal_adder/design.png "Logo Title Text 1")

Instruction
--
Make sure `iverilog` is installed. <br>
To make: `make` <br>
To clean: `clean`

Example
--
To run the example:
  1. `make`
  2. `make runsim` 

Parameters
--
To change number of blocks ie 'N'
  1. go to `past_sequence_adder_tb.v` 
  2. change parameter `N`

To change number of registers in the adder
  1. go to `past_sequence_adder_tb.v`
  2. change parameter `R`
