# About

Testing the interface of HARP AFU by editing the afu_user.v file from HARP linked list AFU sample

## Changes made
1. Remove everything related to cycle detection
2. defined a new register r_counter
3. changed the structure of the FSM to only increment r_counter until it reaches ‘d100
4. write final value of r_counter to virtual memory
