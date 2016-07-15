module comparator
    #(parameter 
        DW = 8
    )
    (
        input wire [DW - 1: 0] inp1,
        input wire [DW - 1: 0] inp2,
        output reg [DW - 1: 0] out_min,
        output reg [DW - 1: 0] out_max
    );
	//wire [DW - 1: 0] out_min_in;
       // wire [DW - 1: 0] out_max_in;
    
    always@(inp1,inp2) 
  	  if (inp1 < inp2) begin
     	   	out_min = inp1;
       	   	out_max = inp2;
    	end 
	else begin
        	out_min = inp2;
       	        out_max = inp1;
    	end
   

	//assign out_min = out_min_in;
	//assign out_max = out_max_in;


endmodule

