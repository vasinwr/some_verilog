// TB: test bench

`timescale 1ps/1ps

// set global data bitwidth
`define DATA_WIDTH    3
`define REGS 2

// test bench
module tb ();

	localparam TB_TIMEOUT =  100_000;  // timeout 100ns
	localparam TB_CLK_PERIOD = 2_000;  // clock period 2ns
	localparam TB_RST_PERIOD = 4_000;  // reset period 4ns


	// clock
	reg tb_clk = 1'b0;
	always #(TB_CLK_PERIOD / 2) tb_clk = ~tb_clk;
        // clock
	reg tb_clk2 = 1'b0;
	always @(posedge tb_clk) #(0.1_000) tb_clk2 = ~tb_clk2;
	//reset
	reg tb_rst = 1'b1;
	initial begin
		#(TB_RST_PERIOD) tb_rst = 1'b0;
	end

	// dump
	initial begin
		$dumpvars;
	end
	
	// timeout
	initial #(TB_TIMEOUT) begin
		//$display("close files...");
		//$fclose(infile);
		//$fclose(outfile);
		//$display("...done");
		$finish();
		//$display("after finish");
	end

	localparam data_width = `DATA_WIDTH;

	// DUT
	wire [data_width - 1 : 0] dut_inp_a;
	wire [data_width - 1 : 0] dut_inp_b;
	wire [data_width : 0] dut_outp;

        pipelined_adder	 
		# (
			.INP_DW(data_width),
                        .NUM_REG(`REGS)
		)
		DUT 
		(
                .clk(tb_clk),
		.inp1(dut_inp_a),
		.inp2(dut_inp_b),
		.outp(dut_outp)
		);

	// tb_master to drive DUT and receive its output
	tb_master
		# (
			.data_width(data_width)
		)
		tb_master
		(
			.clk(tb_clk),
			.rst(tb_rst),
			.reg_a(dut_inp_a),
			.reg_b(dut_inp_b),
			.inp(dut_outp)
		);


endmodule
