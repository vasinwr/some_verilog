// Verilog testbench

`timescale 1ps/1ps
`define num_bits 128


module inter_tb ();

	// note this only runs for 50 cycles with the below settings
	// alter TB_TIMEOUT to run longer
	localparam TB_TIMEOUT    = 100000;
	localparam TB_CLK_PERIOD = 2000;
	localparam TB_RST_PERIOD = 4000;

	initial  #(TB_TIMEOUT) $finish();

	// clock
	reg tb_clk = 1'b0;
	always #(TB_CLK_PERIOD/2) tb_clk = ~tb_clk;


	wire [127: 0] outp;


	inter_test #(
		.num_bits(`num_bits)

	) my_matrix_mult_vector_test (
		.clk(tb_clk),
		.outputer(outp)
		);
	// display inputs and output on each clock cycle
	always @(posedge tb_clk) begin
		$display(" => outp = ", outp);
	end

endmodule
