module sequence_input_compare
    #(parameter
        DW = 8
    )
    (
 	input wire clk,
        input wire [DW -1 :0] inp,
        output wire [DW-1 :0] outp,
	output wire [DW-1 :0] max
    );

	wire [DW-1 :0] outwire1;
	wire [DW-1 :0] outwire2;
	wire [DW-1 :0] outwire3;
	wire [DW-1 :0] outwire4;

	reg [DW-1 :0] outreg1;
	reg [DW-1 :0] outreg2;
	reg [DW-1 :0] outreg3;
	reg [DW-1 :0] outreg4;

	wire [DW-1 :0] input_change;

	wire [DW-1 :0] min[1:4];



	reg[1:0] count;
	initial count=2'b0;
	assign input_change= inp+2**(DW-1);

	always@(posedge clk) begin
				

				outreg1<=outwire1;
				outreg2<=outwire2;
				outreg3<=outwire3;
				outreg4<=outwire4;

				if(count == 2'b11) begin
					count<=2'b0;
				end
				else begin
					count<=count+1'b1;
				end
				if(count == 2'b11) begin
					//outreg1[DW-1] <=outreg1 - 2^(DW-1);

					outreg1[DW-1] <=0;
					outreg2[DW-1] <=0;
					outreg3[DW-1] <=0;
					outreg4[DW-1] <=0;
				end


	end//end of block



    comparator #(.DW(DW)) cmp1 ( .inp1(input_change),
				.inp2(outreg1),
                               .out_min(min[1]),
				.out_max(outwire1)
                              );
    comparator #(.DW(DW)) cmp2 ( .inp1(min[1]),
				.inp2(outreg2),
                               .out_min(min[2]),
				.out_max(outwire2)
                              );
    comparator #(.DW(DW)) cmp3 ( .inp1(min[2]),
				.inp2(outreg3),
                               .out_min(min[3]),
				.out_max(outwire3)
                              );
    comparator #(.DW(DW)) cmp4 ( .inp1(min[3]),
				.inp2(outreg4),
                               .out_min(outp),
				.out_max(outwire4)
                              );


    //assign output
    assign max= outwire1;

endmodule
