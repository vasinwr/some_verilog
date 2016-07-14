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

    //reg [DW-1 : 0] regs [0:2**N-1][0:2**N-1]; // not supported by icarus verilog
    reg [DW-1:0] regs [1:(2**(2*N))];
    wire [DW-1:0] sums [0:N];
    genvar i;

    assign sums[1] = regs[1] + inp;
    generate 
    for (i = 2; i <= N; i = i + 1) begin: sum_loop
        assign sums[i] = sums[i-1] + regs[2**(N+i-2) + 2**(i-1)];
    end
    endgenerate  

    assign outp = sums[N];

   reg j,k; 

    always @ (posedge clk) begin
        regs[1] <= inp;
        for (j = 2; j <= N; j = j + 1) begin
          for (k = 1; k <= j; k = k + 1) begin
              if(k == 1)
                  regs[2**(N+j-2)+k] <= sums[j-1];
              else
                  regs[2**(N+j-2)+k] <= regs[2**(N+j-2)+k-1];
          end            
        end 
    end


endmodule
