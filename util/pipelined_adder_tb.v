// Verilog testbench

`timescale 1ps/1ps
`define INP_DATA_WIDTH 8
`define REGS 4  //wouldn't work with REGS 0

module pipelined_adder_tb ();

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
	wire [`INP_DATA_WIDTH : 0] outp;
	wire [(`INP_DATA_WIDTH) - 1 : 0] inp1;
	wire [(`INP_DATA_WIDTH) - 1 : 0] inp2;

	pipelined_adder_test #(
		.inp_data_width(`INP_DATA_WIDTH),
		.num_regs(`REGS)
	) my_test (
		.clk(tb_clk),
		.outp(outp),
		.outp_inp1(inp1),
                .outp_inp2(inp2)
	);
	// display inputs and output on each clock cycle
	always @(posedge tb_clk) begin
		$display( "inps: ",inp1, " + ", inp2, " => outp = ", outp);
	end

endmodule
