# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := past_sequence_adder.v past_sequence_adder_test.v past_sequence_adder_tb.v

.PHONY : all

all: past_sequence_adder


# build simulation
past_sequence_adder : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) past_sequence_adder


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) past_sequence_adder

