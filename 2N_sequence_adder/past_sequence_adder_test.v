module past_sequence_adder_test
    #(parameter
        data_width = 8,
        N = 4
    )
    (
        input wire clk,
        output wire [data_width - 1: 0] outp,
        output wire [data_width - 1: 0] outp_inps
    );

    reg [data_width-1: 0] count;

    initial begin
      count = 0;
    end

    always @ (posedge clk)
        count <= count + 1;
    assign outp_inps = count;

    past_sequence_adder
        #(
            .N(N),
            .DW(data_width)
        ) my_past_sequence_adder (
            .clk(clk),
            .inp(count),
            .outp(outp)
        );

endmodule

