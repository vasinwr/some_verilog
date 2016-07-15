module balance_tree_adder
    #(parameter
        N = 4,
        DW = 8
    )
    (
        input wire clk,
        input wire [(2**N)*DW - 1 : 0] inp,
        output wire [N*DW - 1 : 0] outp
    );

    wire [DW-1:0] regs [1:(2**(2*N))]; // 

	genvar k;
   	genvar j;
 	assign outp =regs[2**N+2]+regs[2**N+1];

    generate  // j=N-1
          for (k = 1; k <= 2**(N-1); k = k + 1) begin: sum_loop
                  assign regs[2**(N-1)+k] = inp[k*DW-1:(k-1)*DW]+inp[(k+1)*DW-1:k*DW];

          end           
    endgenerate  
 
    generate 
          for (j = 2; j <= (N-2); j = j + 1) begin
          	for (k = 1; k <= 2**(j-1); k = k + 1) begin
                	assign regs[2**(N+j-2)+k] = regs[2**(N+j-1)+2*k]+regs[2**(N+j-1)+2*k-1];
       		   end           
        end 
    endgenerate  



endmodule
