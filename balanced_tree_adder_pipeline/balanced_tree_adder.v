module balance_tree_adder
    #(parameter
        N = 4,
        DW = 8
    )
    (
        input wire clk,
        input wire [(2**N)*DW - 1 : 0] inp,
        output reg [N*DW - 1 : 0] outp
    );

    reg[DW*N-1:0] regs [2:2**N]; // 

	reg[N-1:0] k;
	reg[10:0] m;
   	reg[10:0] j;

	genvar i;
	wire [DW-1:0] arra [0:2**N-1];
    generate 
    for (i = 0; i <= 2**N-1; i = i + 1) begin: input_partition
        assign arra[i] = inp[i*DW+DW-1:i*DW];
    end
    endgenerate  


    always @ (posedge clk) begin

      // j=N-1


 	outp <=regs[2]+regs[3];
          for (j = 1; j <= N-2; j = j + 1) begin
          	for (k = 0; k <= 2**j-1; k = k + 1) begin
                	regs[2**j+k] <= regs[2**(j+1)+2*k]+regs[2**(j+1)+2*k+1];
       		   end           
        end 

          for (m = 0; m <= 2**(N-1)-1; m = m + 1) begin
                   regs[2**(N-1)+m] <= arra[2*m]+arra[2*m+1];

          end           
      
 
  

     
end
endmodule
