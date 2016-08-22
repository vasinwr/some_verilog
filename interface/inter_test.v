module inter_test
  #(parameter 
num_bits=127)
  (
      input wire clk,
//      output wire [(2*data_width + $bits(n_columns))*m_rows - 1  : 0] outp,
      output wire [num_bits - 1 : 0] outputer
  );



      //counter 
assign outputer=outp_reg;
	wire [num_bits - 1 : 0] outp;
	reg [num_bits - 1 : 0] outp_reg;
	wire s1o_valid;
	wire s1i_rdy;
      reg [num_bits - 1 : 0] count;

      initial begin
          count = 0;
      end
      always @ (posedge clk) begin

	if (s1i_rdy==1'b1)begin
		count <= count + 1;
	end

	if (s1o_valid==1'b1)begin
		outp_reg<=outp;
	end

      end
      assign outp_inps = count;

      // instantiate 
      inter#(
		.num_bits(num_bits)
	) 
          interya (
      		.clk(clk),
                   .rst(1'b0),
    
    // These are the signals for stream #1 INto the firmware.
			.s1i_valid(1'b1),
                  .s1i_rdy(s1i_rdy),
           .s1i_data(count),
    
    // These are the signals for stream #1 OUT of the firmware.
             		.s1o_valid(s1o_valid),
                   	.s1o_rdy(1'b1),
          		.s1o_data(outp)
    );
    

endmodule
