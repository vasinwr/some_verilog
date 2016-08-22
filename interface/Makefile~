# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := matrix_mult_matrix.v matrix_mult_matrix_test.v matrix_mult_matrix_tb.v pipelined_inner_product.v

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

