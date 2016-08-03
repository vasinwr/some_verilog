# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := sequence_input_compare.v sort4_sequence_test.v tb_sort_4sequence.v comparator.v

.PHONY : all

all: sort4number


# build simulation
sort4number : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) sort4number

.PHONY : test
test: runsim
	python "gen_expected.py"
	diff expected.txt output.txt
	echo "ALL OK!"


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) sort4number
