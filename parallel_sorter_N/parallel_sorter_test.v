module parallel_sorter_test
  #(parameter 
      data_width = 3,
      num_elem = 4
  )
  (
      input wire clk,
      output wire [num_elem * data_width - 1 : 0] outp_inps,
      output wire [(data_width*num_elem) -1 :0] outp
  );

  localparam
      num_bits = data_width * num_elem;

      //counter 
      reg [num_elem * data_width - 1 : 0] count;
      initial begin
          count = 686;
      end
      always @ (posedge clk)
          count <= count + 1;
      assign outp_inps = count;

      // instantiate 
      parallel_sorter
          #(
                .DW(data_width),
                .N(num_elem)
          ) sorter (
                .inp(count),
                .outp(outp)
          );

endmodule
