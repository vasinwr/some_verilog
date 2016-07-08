# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := sort5number.v sort5number_test.v sort5number_tb.v comparator.v

.PHONY : all

all: sort5number


# build simulation
sort5number : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) sort5number


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) sort5number
