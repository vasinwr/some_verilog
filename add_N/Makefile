# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := add_N.v add_N_test.v add_N_tb.v

.PHONY : all

all: add_N


# build simulation
add_N : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) add_N


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) add_N

