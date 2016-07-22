// take 2 inputs of width INP_DW, gives 1 output of width INP_DW+1

module pipelined_adder
    #(parameter
        INP_DW = 8,
        NUM_REG = 4
    )
    (
        input wire clk,
        input wire [INP_DW-1:0] inp1,
        input wire [INP_DW-1:0] inp2,
        output wire [INP_DW:0] outp
    );

    reg[INP_DW:0] regs [1:NUM_REG];
    reg [NUM_REG-1:0] i;   //ideally, width should be number of bits required to contain (NUM_REG-1); 
                           //ie $bits(NUM_REG-1) but $bits doesn't do what we thought it does.
    
    always@(posedge clk) begin
        regs[1] <= inp1 + inp2; 
        for(i = 2; i <= NUM_REG; i = i+1) begin 
            regs[i] <= regs[i-1];
        end
    end

    assign outp = regs[NUM_REG];

endmodule
