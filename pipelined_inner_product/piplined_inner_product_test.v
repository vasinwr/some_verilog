module pipelined_inner_product_test 
  (
      input wire clk,
      output wire [7:0] outp,
      output wire [8: 0] outp_inps
  );

      //counter 
      reg [8 : 0] count;
      initial begin
          count = 0;
      end
      always @ (posedge clk)
          count <= count + 1;
      assign outp_inps = count;

      // instantiate 
      pipelined_inner_product
           my_inner_product (
                .clk(clk),
                .inp1(count),
                .inp2(count), // takes in count as 2 inputs 
                .outp(outp)
          );

endmodule
