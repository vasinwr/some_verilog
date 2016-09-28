module pipelined_adder_test
    #(parameter 
        inp_data_width = 8,
        num_regs = 4
    )
    (
        input wire clk,
        output wire [inp_data_width : 0] outp,
        output wire [inp_data_width - 1: 0] outp_inp1,
        output wire [inp_data_width - 1: 0] outp_inp2
    );

    reg [inp_data_width - 1: 0] count_up, count_down;
    initial begin
      count_up = 0;
      count_down = 0;
    end
    
    always @ (posedge clk) begin
        count_up <= count_up + 1;
        count_down <= count_down - 1;
    end

    assign outp_inp1 = count_up;
    assign outp_inp2 = count_down;

    pipelined_adder
        #(
            .INP_DW(inp_data_width),
            .NUM_REG(num_regs)
        ) my_adder (
            .clk(clk),
            .inp1(count_up),
            .inp2(count_down),
            .outp(outp)
        );

endmodule
