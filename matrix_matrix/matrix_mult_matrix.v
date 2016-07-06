module matrix_mult_matrix
  (
      input wire clk,
      input wire[3*3*3-1 : 0] matrix_inp1, //26
      input wire[3*3*3-1 : 0] matrix_inp2, //26
      output wire[8*3*3 -1 : 0] outp //71
  );

  localparam out_dw = 8; //output dw from innerproduct
  localparam row_dw = 3*8;

  //locals
  genvar i,j;
  wire [8*3*3-1 : 0] dot_products; // dot products from each row 
  //tranpose
  wire [3*3-1:0] vectors[0:2];
  assign vectors[2] = { matrix_inp2[26:24], matrix_inp2[17:15], matrix_inp2[8:6] };
  assign vectors[1] = { matrix_inp2[23:21], matrix_inp2[14:12], matrix_inp2[5:3] };
  assign vectors[0] = { matrix_inp2[20:18], matrix_inp2[11:9], matrix_inp2[2:0] };

  ///compute
  generate 
      for (i = 0; i < 3; i = i + 1) begin: product_loop1
          for (j = 0; j < 3; j = j + 1) begin: product_loop2
              pipelined_inner_product
                my_inner_product (
                      .clk(clk),
                      .inp1(matrix_inp1[3*3*(i+1) - 1 : 3*3*i]),
                      .inp2(vectors[j]),  
                      .outp(dot_products[8*(j+1) + i*row_dw -1 : 8*j + i*row_dw])
                );
          end
      end
  endgenerate

  assign outp = dot_products; 


endmodule
