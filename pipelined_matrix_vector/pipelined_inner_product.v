module pipelined_inner_product
  (
      input wire clk,
      input wire[8 : 0] inp1, // vector of 3 bits. 3 elements
      input wire[8 : 0] inp2,
      output wire[7 : 0] outp  // 8 bits output
  );

  //locals
  wire [23 : 0] sums[0 : 2]; // intermediate product sums
  reg [7:0] rsum1, rsum2, rprod2, rprod3, rprod3_1;


  assign sums[0] = inp1[2:0] * inp2[2:0];
  assign sums[1] = rsum1 + rprod2;
  assign sums[2] = rsum2 + rprod3_1;

  always @ (posedge clk) begin
      rsum1   <= sums[0];
      rprod2  <= inp1[5:3] * inp2[5:3];
      rsum2   <= sums[1];
      rprod3  <= inp1[8:6] * inp2[8:6];
      rprod3_1 <= rprod3;
  end

  assign outp = sums[2]; 

endmodule
