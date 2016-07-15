# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := parallel_sorter.v parallel_sorter_test.v parallel_sorter_tb.v comparator.v

.PHONY : all

all: parallel_sorter


# build simulation
parallel_sorter : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) parallel_sorter


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) parallel_sorter
