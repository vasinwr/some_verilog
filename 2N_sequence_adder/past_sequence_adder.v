module past_sequence_adder
    #(parameter
        N = 4,
        DW = 8
    )
    (
        input wire clk,
        input wire [DW - 1 : 0] inp,
        input wire [DW - 1 : 0] outp
    );

    //localparam geo_sum = (1-2**N)/(1-2);   // number of reg needed = geometric sum = a(1-r^n)/(1-r) where a = 1, r = 2, n = N 
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

    

    always @ (posedge clk) begin

    end
endmodule
