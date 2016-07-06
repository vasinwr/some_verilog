module matrix_mult_vector
  (
      input wire clk,
      input wire[26 : 0] matrix_inp,
      input wire[8 : 0] vector_inp,
      output wire[23 : 0] outp
  );

  //locals
  genvar i;
  wire [23 : 0] dot_products; // dot products from each row 


  ///compute
  generate 
      for (i = 0; i < 3; i = i + 1) begin: product_loop
        // instantiate 
        pipelined_inner_product
           my_inner_product (
                .clk(clk),
                .inp1( matrix_inp[9*(i+1) - 1 : 9*i] ),
                .inp2(vector_inp),  
                .outp(dot_products[8*(i+1)-1 : 8*i])
          );
      end
  endgenerate

  assign outp = dot_products; 


endmodule
