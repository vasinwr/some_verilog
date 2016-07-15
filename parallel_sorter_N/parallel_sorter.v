module parallel_sorter
    #(parameter 
        N = 4,
        DW = 8
    )
    (
        input wire [(DW*N)-1 : 0] inp,
        output wire [(DW*N)-1 : 0] outp
    );

    localparam row = N;
    localparam column = N*2;

    wire [DW-1 : 0] wire_grid [0: row*column -1]; // wire_grid [0:row][0:column]

    genvar r;
    generate
      // takes care edge cases
        for (r = 0; r < row; r = r + 1) begin       
            //assign wire_grid[r][1+(r*2)] = wire_grid[r][r*2];  
            assign wire_grid[(r*row) + (r*2) + 1] = wire_grid[(r*row) + (r*2)];
        end
      // assign outputs
        for (r = 0; r < N; r = r + 1) begin
            //assign outp[DW*(r+1)-1 : DW*r] = wire_grid[r*2+1][row-1]; 
            assign outp[DW*(r+1)-1 : DW*r] = wire_grid[(r*2+1)*row + row-1];
        end 
    endgenerate

    
    genvar i,j;
    generate
        for (i = 1; i < row; i = i+1) begin 
            for (j = 1; j < column-(row-i)*2 ; j = j+2) begin  //TODO fix this line
                comparator #(.DW(DW)) cmp ( .inp1(wire_grid[(i-1)*row + j]),    //[i-1][j]
                                            .inp2(wire_grid[i*row + (j-1)]),    //[i][j-1]
                                            .out_min(wire_grid[(i+1)*row + j]), //[i+1][j]
                                            .out_max(wire_grid[i*row + (j+1)])  //[i][j+1]
                                          );
            end
        end 
    endgenerate

endmodule
