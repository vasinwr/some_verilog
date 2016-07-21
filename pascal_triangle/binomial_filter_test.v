module binomial_filter_test
	#(parameter
		data_width = 8,
                num_elem = 4
	)
	(
		input wire clk,
		output wire [data_width - 1 : 0] outp,
		output wire [data_width - 1 : 0] outp_inps
	);

	// counter
	reg [data_width-1 : 0] count;
	initial begin
		count = 0;
	end
	always @ (posedge clk)
		count <= count + 1;
	assign outp_inps = count;
	
	// instantiate DUT
	binomial_filter
		#(
			.DW(data_width),
                        .N(num_elem)
		) my_add_N (
                        .clk(clk),
			.inp(count),
			.outp(outp)
		);


endmodule
