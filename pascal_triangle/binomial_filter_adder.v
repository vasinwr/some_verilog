module binomial_filter_adder
    #(parameter 
          DW = 8
    )
    (
      input wire clk,
      input wire [DW-1 : 0] inp,
      output wire [DW-1 : 0] outp
    );

    reg [DW-1:0] r_in;

    always @ (posedge clk) begin
        r_in <= inp;
    end

    assign outp = r_in + inp;
endmodule
        
    
