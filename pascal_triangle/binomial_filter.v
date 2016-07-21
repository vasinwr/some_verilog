module binomial_filter
    #(parameter 
        N = 4,
        DW = 8
    )
    (
        input wire clk,
        input wire [DW-1: 0] inp,
        output wire [DW-1: 0] outp
    );

    reg  [DW-1 : 0] regs [1:N];
    wire [DW-1 : 0] inps [1:N];
    wire [DW-1 : 0] outps [1:N];

    genvar i;

    
    assign inps[1] = inp;
    generate 
        for (i = 1; i <= N; i = i+1) begin 
            binomial_filter_adder #(.DW(DW)) add ( .clk(clk),
                                                   .inp(inps[i]),
                                                   .outp(outps[i])
                                                 );
            if(i != 1) begin
                assign inps[i] = regs[i-1];
            end
        end
    endgenerate
        
    assign outp = outps[N];

    reg [10:0] j;

    always @ (posedge clk) begin
        for(j = 1 ; j <= N; j = j+1) begin
            regs[j] <= outps[j];
        end
    end
    
endmodule

