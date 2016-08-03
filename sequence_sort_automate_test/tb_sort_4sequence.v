// Verilog testbench

`timescale 1ps/1ps
`define DATA_WIDTH 9
`define NUM_ELEMS 1


module tb_sort_4sequence ();

	// note this only runs for 50 cycles with the below settings
	// alter TB_TIMEOUT to run longer
	localparam TB_TIMEOUT    = 96000;
	localparam TB_CLK_PERIOD = 2000;
	localparam TB_RST_PERIOD = 4000;

	reg ini;
	reg writeoutput;

	reg[1:0] count;
	reg[1:0] countout;
	integer outfile;
	integer infile;

	initial count=2'b0;
	initial countout=2'b0;
	initial ini=1'b0;
	initial writeoutput=1'b0;
	initial begin
		outfile = $fopen("output.txt", "w");
		infile = $fopen("input.txt", "w");
		if (0 == outfile) begin
			$display("ERROR: could not open output.txt");
			$finish();
		end
		if (0 == infile) begin
			$display("ERROR: could not open input.txt");
			$finish();
		end
	end




	initial  #(TB_TIMEOUT) $finish();

	// clock
	reg tb_clk = 1'b0;
	always #(TB_CLK_PERIOD/2) tb_clk = ~tb_clk;


	// DUT
	wire [(`NUM_ELEMS * `DATA_WIDTH)-1 : 0] outp;
	wire [(`NUM_ELEMS * `DATA_WIDTH) - 1 : 0] inps;
	wire [(`NUM_ELEMS * `DATA_WIDTH) - 1 : 0] max;

	sort4_sequence_test #(
		.data_width(`DATA_WIDTH)
	) my_inner_product_test (
		.clk(tb_clk),
		.outp(outp),
                .max(max),
		.outp_inps(inps) // the count
		);
	// display inputs and output on each clock cycle
	always @( posedge tb_clk) begin
		ini<=1'b1;
		count<=count+1'b1;

		if (ini == 1'b0) begin
			count<=2'b0;
		end


		if(count == 2'b11) begin
			$fwrite(infile, "\n");
			
		end


		if(count == 2'b10) begin
			writeoutput<=1'b1;			
		end
		if (writeoutput == 1'b1) begin
			countout<=countout+1'b1;
			$fwrite(outfile, "%d ", outp);

		end
		if(countout == 2'b11) begin
			$fwrite(outfile, "\n");			
		end


	
		$display("inps = ", inps, " => outp = ", outp, " max = ", max);

		$fwrite(infile, "%d ", inps);
	end

endmodule
