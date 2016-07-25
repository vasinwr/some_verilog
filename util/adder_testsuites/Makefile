# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := pipelined_adder.v tb.v tb_master.v

.PHONY : all

all: pipelined_adder


# build simulation
pipelined_adder : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) pipelined_adder

.PHONY : test
test: runsim
	diff expected.txt output.txt
	echo "ALL OK!"

# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) pipelined_adder

