module past_balance_tree_adder
    #(parameter
        N = 4,
        DW = 8
    )
    (
        input wire clk,
        input wire [(2**N)*DW - 1 : 0] inp,
        output wire [N*DW - 1 : 0] outp
    );

    wire [DW-1:0] regs [1:(2**(2*N))]; // 2d array not supported by icarus

    genvar i;

    generate 
          for (j = 1; j <= (N-1); j = j + 1) begin
         // $display("A: j=",j," k=",k);
          for (k = 1; k <= 2**(j-1); k = k + 1) begin
         //   $display("B: j=",j," k=",k);
            if(j == (N-1)) begin
        //          $display("B1");
                  regs[2**(N-1)+k] <= inp[k*DW-1:(k-1)*DW]+inp[(k+1)*DW-1:k*DW];
            end 
            else begin
           //       $display("B2");
                  regs[2**(N+j-1)+k] <= regs[2**(N+j-2)+k-1];
            end 
          end           
        end 
    endgenerate  


    assign sums[1] = regs[1] + inp;
    generate 
    for (i = 2; i <= N; i = i + 1) begin: sum_loop
        assign sums[i] = sums[i-1] + regs[2**(N+i-2) + 2**(i-1)];
    end
    endgenerate  

    assign outp = sums[N];

    // localparam n = $bit(N); // this doesn't work, why?

    reg[10:0] j,k;  // should be $bit(N) , but 10 will work but it should depends on N. 
                    // ISSUE: when reg[3:0] and N = 3, this will not work.
                    // Why?

    always @ (posedge clk) begin
	
        regs[1] <= inp;
        for (j = 2; j <= N; j = j + 1) begin
         // $display("A: j=",j," k=",k);
          for (k = 1; k <= 2**(j-1); k = k + 1) begin
         //   $display("B: j=",j," k=",k);
            if(k == 1) begin
        //          $display("B1");
                  regs[2**(N+j-2)+k] <= sums[j-1];
            end 
            else begin
           //       $display("B2");
                  regs[2**(N+j-2)+k] <= regs[2**(N+j-2)+k-1];
            end 
          end           
        end 
    end


endmodule
