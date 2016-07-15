module balanced_adder_test
    #(parameter
        data_width = 8,
        N = 4
    )
    (
        input wire clk,
        output wire [data_width*N - 1: 0] outp,
        output wire [(2**N)*data_width-1: 0] outp_inps
    );

    reg [(2**N)*data_width-1: 0] count;

    initial begin
      count = 0;
    end
	initial count = 32;
    always @ (posedge clk)
        count <= count + 1;
    assign outp_inps = count;

    balance_tree_adder
        #(
            .N(N),
            .DW(data_width)
        ) my_past_sequence_adder (
            .clk(clk),
            .inp(count),
            .outp(outp)
        );

endmodule

