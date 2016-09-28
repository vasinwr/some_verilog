# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := pipelined_adder.v pipelined_adder_test.v pipelined_adder_tb.v

.PHONY : all

all: pipelined_adder


# build simulation
pipelined_adder : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) pipelined_adder


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) pipelined_adder

