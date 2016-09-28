// N-input, combinatorial fixed-point adder in Verilog


module add_N
	#(parameter 
		N = 4,    // no. elements to sum
		DW = 8    // data bitwidth
	)
	(
		// note Xilinx XVlog does not allow arrays as ports
		input wire [(DW * N) - 1 : 0] inp,
		output wire [DW - 1 : 0] outp
	);

	/// locals
	genvar i;
	wire [DW - 1 : 0] sums[0 : N - 1]; // intermediate sums

	/// compute
	assign sums[0] = inp[DW - 1 : 0];
	// unbalanced tree reduction
	generate
		for (i = 1 ; i < N ; i = i + 1) begin: sum_loop
			assign sums[i] = sums[i - 1] 
				+ inp[(i + 1) * DW - 1 : i * DW];
		end
	endgenerate

	/// output
	assign outp = sums[N - 1];

endmodule
