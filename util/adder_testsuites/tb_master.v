// TB master: generate inputs for test bench

module tb_master 
	# ( parameter
		data_width = 8
	)
	(
	input wire clk,
	input wire rst,

	// outputs: generated inputs for DUT
	output reg [data_width - 1 : 0] reg_a,
	output reg [data_width - 1 : 0] reg_b,

	// input: outputs of DUT
	input wire [data_width : 0] inp
	);

	

	// file handles
	integer infile, outfile;
	// status of file input
	integer statusI;

	integer in_a, in_b;
	integer count = 0;

	// open and check files
	initial begin
		infile = $fopen("input.txt", "r");
		outfile = $fopen("output.txt", "w");
		if (0 == infile) begin
			$display("ERROR: could not read input.txt");
			$finish();
		end
		if (0 == outfile) begin
			$display("ERROR: could not open output.txt");
			$finish();
		end
	end


	// write outputs to file, then read inputs from file
	always @ (posedge clk) begin
		if (rst) begin
			reg_a <= 0;
			reg_b <= 0;
		end
		if (~rst) begin
			count <= count + 1;
			if (count > 0) begin
				$fwrite(outfile, "%d %d -> %d\n", reg_a, reg_b, inp);
			end
			// print inputs and outputs on each cycle
			#(1_000)$display($time, ": a=%d, b=%d => =%d", reg_a, reg_b, inp);   //added delay to give time to DUT because DUT uses clk as well
			// read inputs from file
			statusI = $fscanf(infile, "%d %d\n", reg_a, reg_b);
			//statusI = $fscanf(infile, "%d %d\n", in_a, in_b);
			//reg_a <= in_a;
			//reg_b <= in_b;
		end
	end


endmodule

