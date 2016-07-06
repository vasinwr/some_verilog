module matrix_mult_matrix_test
  #(parameter 
      m_rows = 3,
      n_columns = 3, //also is the dimension of vector
      data_width = 3)
  (
      input wire clk,
//      output wire [(2*data_width + $bits(n_columns))*m_rows - 1  : 0] outp,
      output wire [8*3*3 -1 : 0] outp,
      output wire [n_columns * data_width - 1 : 0] outp_inps
  );

  localparam
      num_bits = data_width * n_columns; // size in bits of a vector

      //counter 
      reg [num_bits - 1 : 0] count;
      reg [num_bits * m_rows -1 : 0] multiple_counts; // for matrix input
      initial begin
          count = 0;
          multiple_counts = 0;
      end
      always @ (posedge clk) begin
          count <= count + 1;
          multiple_counts <= multiple_counts + 1; // TODO: count value in all rows
      end
      assign outp_inps = count;

      // instantiate 
      matrix_mult_matrix
          my_matrix_mult_matrix (
                .clk(clk),
                .matrix_inp1(multiple_counts),
                .matrix_inp2(multiple_counts), // takes in count as 2 inputs 
                .outp(outp)
          );

endmodule
