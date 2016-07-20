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

    wire [DW*N-1:0] regs [1:2**N]; // 

	genvar k;
   	genvar j;
 	assign outp =regs[2]+regs[3];

    generate  // j=N-1
          for (k = 0; k <= 2**(N-1)-1; k = k + 1) begin: sum_loop
                  assign regs[2**(N-1)+k] = inp[2*k*DW+DW-1:2*k*DW]+inp[2*k*DW+2*DW-1:2*k*DW+DW];

          end           
    endgenerate  
 
    generate 
          for (j = 1; j <= N-2; j = j + 1) begin
          	for (k = 0; k <= 2**j-1; k = k + 1) begin
                	assign regs[2**j+k] = regs[2**(j+1)+2*k]+regs[2**(j+1)+2*k+1];
       		   end           
        end 
    endgenerate  



endmodule
