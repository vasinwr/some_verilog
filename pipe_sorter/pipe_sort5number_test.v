module pipe_sort5number_test
  #(parameter 
      data_width = 3)
  (
      input wire clk,
      output wire [4 * data_width - 1 : 0] outp_inps,
      output wire [(data_width*4) -1 :0] outp
  );

  localparam
      num_bits = data_width * 4;

      //counter 
      reg [4 * data_width - 1 : 0] count;
      initial begin
          count = 686;
      end
      always @ (posedge clk)
          count <= count + 1;
      assign outp_inps = count;

      // instantiate 
      pipe_sort5number
          #(
                .DW(data_width)
          ) my_inner_product (
		.clk(clk),
                .inp(count),
                .outp(outp)
          );

endmodule
