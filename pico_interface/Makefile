# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := inter.v inter_test.v inter_tb.v

.PHONY : all

all: matrix_mult_matrix


# build simulation
matrix_mult_matrix : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) matrix_mult_matrix


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) matrix_mult_matrix

