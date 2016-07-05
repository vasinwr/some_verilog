# build and run simulation
# 

# tools
VERILOG:=iverilog
SIMULATOR:=vvp

SRCS := pipelined_inner_product.v pipelined_inner_product_test.v pipelined_inner_product_tb.v

.PHONY : all

all: pipelined_inner_product


# build simulation
pipelined_inner_product : $(SRCS)
	$(VERILOG) -o $@  $(SRCS)	


# run simulation
.PHONY : runsim
runsim:
	$(SIMULATOR) pipelined_inner_product


# cleanup
.PHONY : clean
clean:
	$(RM) *.o

# delete all built files
.PHONY : realclean
realclean:
	$(RM) pipelined_inner_product
