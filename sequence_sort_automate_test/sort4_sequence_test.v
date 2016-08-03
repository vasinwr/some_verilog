module sort4_sequence_test
  #(parameter 
      data_width = 3)
  (
      input wire clk,
      output wire [data_width - 1 : 0] outp_inps,
      output wire [data_width-1 :0] outp,
	output wire [data_width-1 :0] max
  );

	reg subout;
	reg[1:0] countin;

	integer outfile;
	initial begin
		outfile = $fopen("output.txt", "w");
		if (0 == outfile) begin
			$display("ERROR: could not open output.txt");
			$finish();
		end
	end

	initial countin=2'b0;
	initial subout=0;
// timing: when to set subout
	always@(posedge clk) begin
				if(countin == 2'b11) begin
					countin<=2'b0;
					subout<=1'b1;
				end
				else begin
					countin<=count+1'b1;
					subout<=1'b0;
				end	
	end//end of block



      //counter 
      reg [data_width - 1 : 0] count;
      initial begin
          count = 180;
      end
      always @ (posedge clk) begin 
          count <= count - 1;

	end
      assign outp_inps = count;

      // instantiate 
      sequence_input_compare
          #(
                .DW(data_width)
          ) my_inner_product (
		.clk(clk),
                .inp(count),
                .max(max),
                .outp(outp)
          );

endmodule
