# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := pipe_sort5number.v pipe_sort5number_test.v sort5number_tb.v comparator.v

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
