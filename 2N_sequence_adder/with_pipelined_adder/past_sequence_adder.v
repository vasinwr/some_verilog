module past_sequence_adder
    #(parameter
        N = 4,
        DW = 8
    )
    (
        input wire clk,
        input wire [DW - 1 : 0] inp,
        output wire [DW - 1 : 0] outp
    );

    reg [DW-1:0] regs [1:(2**(2*N))]; // 2d array not supported by icarus
    wire [DW-1:0] regs_wire [1:(2**(2*N))];

    // mapping regs to wire to make it compatable with the pipelined_adder
    genvar x;
    generate 
    for (x = 1; x <= 2**(2*N); x = x+1) begin: regs_wire_map
        assign regs_wire[x] = regs[x];
    end
    endgenerate 



    wire [DW-1:0] sums [0:N];
    genvar i;

    //assign sums[1] = regs[1] + inp;
    pipelined_adder #(.INP_DW(DW), .NUM_REG(2)) add1 (.inp1(regs_wire[1]), .inp2(inp), .outp(sums[1]), .clk(clk));

    generate 
    for (i = 2; i <= N; i = i + 1) begin: sum_loop
        //assign sums[i] = sums[i-1] + regs[2**(N+i-2) + 2**(i-1)];
        pipelined_adder #(.INP_DW(DW), .NUM_REG(2)) add (.inp1(sums[i-1]), .inp2(regs_wire[2**(N+i-2)+2**(i-1)]), .outp(sums[i]), .clk(clk));
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
