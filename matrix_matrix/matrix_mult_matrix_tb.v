// Verilog testbench

`timescale 1ps/1ps
`define DATA_WIDTH 3
`define NUM_ELEMS  3
`define NUM_ROWS 3

module matrix_mult_matrix_tb ();

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
//	wire [(2*`DATA_WIDTH + $bits(`NUM_ELEMS)) * `NUM_ROWS - 1  : 0] outp;
//	//////$bits(3) = 3 not 2, why?
	wire [71  : 0] outp;
	wire [(`NUM_ELEMS * `DATA_WIDTH) - 1 : 0] inps;

	matrix_mult_matrix_test #(
		.data_width(`DATA_WIDTH),
		.n_columns(`NUM_ELEMS),
                .m_rows(`NUM_ROWS)
	) my_matrix_mult_vector_test (
		.clk(tb_clk),
		.outp(outp),
		.outp_inps(inps) // the count
		);
	// display inputs and output on each clock cycle
	always @(posedge tb_clk) begin
		$display("inps = ", inps, " => outp = ", outp);
	end

endmodule
