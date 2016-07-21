# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := binomial_filter.v binomial_filter_test.v binomial_filter_tb.v binomial_filter_adder.v

.PHONY : all

all: binomial_filter


# build simulation
binomial_filter : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) binomial_filter


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) binomial_filter
