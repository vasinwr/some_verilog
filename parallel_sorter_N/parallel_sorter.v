module parallel_sorter
    #(parameter 
        N = 4,
        DW = 8
    )
    (
        input wire [(DW*N)-1 : 0] inp,
        output wire [(DW*N)-1 : 0] outp
    );

    localparam col = N;
    localparam row = N*2;

    wire [DW-1 : 0] wire_grid [0: row*col -1]; // wire_grid [0:row][0:column] ,[y-axis][x-axis]


    //why cant this be a for loop in 'initial'?
    genvar r;
    generate
      // takes care edge cases
        for (r = 1; r < row; r = r + 2) begin       
            //assign wire_grid[r][(r-1)/2] = wire_grid[r-1][(r-1)/2];  
            assign wire_grid[(r*col) + (r-1)/2] = wire_grid[(r-1)*col + (r-1)/2];
        end
      // assign outputs
        for (r = 0; r < N; r = r + 1) begin
            //assign outp[DW*(r+1)-1 : DW*r] = wire_grid[r*2+1][col-1]; 
            assign outp[DW*(r+1)-1 : DW*r] = wire_grid[(r*2+1)*col + col-1];
        end 
    endgenerate

    
    genvar i,j;
    generate
        for (i = 1; i < col; i = i+1) begin 
            for (j = 1; j < i*2 ; j = j+2) begin  
                  comparator #(.DW(DW)) cmp ( .inp1(wire_grid[i*col + (j-1)]),    //[i][j-1]
                                              .inp2(wire_grid[(i-1)*col + j]),    //[i-1][j]
                                              .out_min(wire_grid[i*col + j]),     //[i][j]
                                              .out_max(wire_grid[(i+1)*col + j])  //[i+1][j]
                                            );
            end
        end 
    endgenerate

endmodule
