// Verilog testbench

`timescale 1ps/1ps
`define DATA_WIDTH 8
`define NUM_ELEM 3

module add_N_tb ();

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
	wire [`DATA_WIDTH-1 : 0] outp;
	wire [`DATA_WIDTH-1 : 0] inps;

	binomial_filter_test #(
		.data_width(`DATA_WIDTH),
                .num_elem(`NUM_ELEM)
	) my_add_N_test (
		.clk(tb_clk),
		.outp(outp),
		.outp_inps(inps)
		);
	// display inputs and output on each clock cycle
	always @(posedge tb_clk) begin
		$display("inps = ", inps, " => outp = ", outp);
	end

endmodule
