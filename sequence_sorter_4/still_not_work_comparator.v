module comparator
    #(parameter 
        DW = 8
    )
    (
        input wire [DW - 1: 0] inp,
        input wire substract,
	input wire clk,
        output reg [DW - 1: 0] out_min
    );
	//wire [DW - 1: 0] out_min_in;
       // wire [DW - 1: 0] out_max_in;


	reg [DW - 1: 0] max;
    	initial max=0;

    	always@(inp,max) begin
  	  if (inp > max) begin
		out_min <= max;
		max <= inp;
    	end 
	else begin
		out_min <= inp;
    	
    	end   
	end

      always @ (posedge clk) begin
	if (substract == 1'b1)begin // these lines do not play any effect
		max[DW-1] <= 0;	
	end
      end


	//assign out_min = out_min_in;
	//assign out_max = out_max_in;


endmodule

