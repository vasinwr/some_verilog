// Verilog testbench

`timescale 1ps/1ps
`define DATA_WIDTH 8
`define NUM_ELEMS 1


module tb_sort_4sequence ();

	// note this only runs for 50 cycles with the below settings
	// alter TB_TIMEOUT to run longer
	localparam TB_TIMEOUT    = 100000;
	localparam TB_CLK_PERIOD = 2000;
	localparam TB_RST_PERIOD = 4000;

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
		$display("inps = ", inps, " => outp = ", outp, " max = ", max);
	end

endmodule
