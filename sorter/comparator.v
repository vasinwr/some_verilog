module comparator
    #(parameter 
        DW = 8
    )
    (
        input wire [DW - 1: 0] inp1,
        input wire [DW - 1: 0] inp2,
        output wire [DW - 1: 0] out_min,
        output wire [DW - 1: 0] out_max
    );
    
    
    if (inp1 < inp2) begin
        out_min <= inp1;
        out_max <= inp2;
    end else begin
        out_min <= inp2;
        out_max <= inp1;
    end

endmodule

