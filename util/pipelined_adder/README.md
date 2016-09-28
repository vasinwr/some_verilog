About
--

This adder takes in an integer as a parameter `X` and create `X` number of registers  according the design in figure below. On every clock pulse, the value from the adder will be stored in register 1, and value from register N will be stored in register N+1, and the value from the last register will be output. The purpose of this adder is to demonstrate that in practice an adder can be optimised by method such as pipe-lining and therefore it might not give out the computed output in 1 clock pulse. Therefore using this adder in modules such as `2N_sequence_adder` will result it more robustness. 

![alt text](https://github.com/vasinwr/some_verilog/blob/master/util/pipelined_adder/pipelined_adder.png "Logo Title Text 1")
