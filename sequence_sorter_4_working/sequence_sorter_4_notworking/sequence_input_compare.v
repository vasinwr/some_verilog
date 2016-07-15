module sequence_input_compare
    #(parameter
        DW = 8
    )
    (
 	input wire clk,
        input wire [DW -1 :0] inp,
        output wire [DW-1 :0] outp
    );

	wire [DW-1 :0] mins[1:4];
	reg  [DW-1 :0] input_change;
	reg[1:0] count;
	reg subout;
	initial count=2'b0;
	initial subout=0;

	always@(posedge clk) begin
				input_change<= inp+2^(DW-1);
				if(count == 2'b11) begin
					count<=2'b0;
				end
				else begin
					count<=count+1'b1;
				end
				if(count == 2'b10) begin
					subout<=1'b1;
				end

			subout<=1'b0;
	end//end of block



    comparator #(.DW(DW)) cmp1 ( .inp(input_change),
				.substract(subout),
				.clk(clk),  
                               .out_min(mins[1])
                              );
    comparator #(.DW(DW)) cmp2 ( .inp(mins[1]),
				.substract(subout),
				.clk(clk),  
                               .out_min(mins[2])
                              );
    comparator #(.DW(DW)) cmp3 ( .inp(mins[2]),
				.substract(subout),
				.clk(clk),  
                               .out_min(mins[3])
                              );
    comparator #(.DW(DW)) cmp4 ( .inp(mins[3]),
				.substract(subout),
				.clk(clk),  
                               .out_min(mins[4])
                              );


    //assign output
    assign outp= mins[4];

endmodule
