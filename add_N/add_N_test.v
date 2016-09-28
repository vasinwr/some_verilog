// testbench for add_N





module add_N_test
	#(parameter
		data_width = 8,
		num_elems = 4)
	(
		input wire clk,
		output wire [data_width - 1 : 0] outp,
		output wire [num_elems * data_width - 1 : 0] outp_inps
	);

	localparam 
		num_bits = data_width * num_elems;

	// counter
	reg [num_bits - 1 : 0] count;
	initial begin
		count = 0;
	end
	always @ (posedge clk)
		count <= count + 1;
	assign outp_inps = count;
	
	// instantiate DUT
	add_N
		#(
			.N(num_elems),
			.DW(data_width)
		) my_add_N (
			.inp(count),
			.outp(outp)
		);


endmodule
