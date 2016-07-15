module sort5number
    #(parameter
        DW = 8
    )
    (
        input wire [(DW*4) -1 :0] inp,
        output wire [(DW*4) -1 :0] outp
    );

  
    wire [DW-1 :0] mins[1:6];  //intermediate results, index starts from 1
    wire [DW-1 :0] maxs[1:6];


    comparator #(.DW(DW)) cmp1 (.inp1(inp[DW-1:0]), 
                               .inp2(inp[DW*2-1 : DW]), 
                               .out_min(mins[1]), 
                               .out_max(maxs[1])
                              );
    comparator #(.DW(DW)) cmp2 (.inp1(inp[DW*3-1:DW*2]), 
                               .inp2(mins[1]), 
                               .out_min(mins[2]), 
                               .out_max(maxs[2])
                              );
    comparator #(.DW(DW)) cmp3 (.inp1(maxs[2]), 
                               .inp2(maxs[1]), 
                               .out_min(mins[3]), 
                               .out_max(maxs[3])
                              );
    comparator #(.DW(DW)) cmp4 (.inp1(inp[DW*4 - 1: DW*3]), 
                               .inp2(mins[2]), 
                               .out_min(mins[4]), 
                               .out_max(maxs[4])
                              );

    comparator #(.DW(DW)) cmp5 (.inp1(maxs[4]), 
                               .inp2(mins[3]), 
                               .out_min(mins[5]), 
                               .out_max(maxs[5])
                              );
    comparator #(.DW(DW)) cmp6 (.inp1(maxs[5]), 
                               .inp2(maxs[3]), 
                               .out_min(mins[6]), 
                               .out_max(maxs[6])
                              );


    //assign output
genvar l;
  generate 
        for(l = 1; l < 4; l = l + 1) begin: hello
            assign outp[DW*(l)-1: DW*(l-1)] = mins[3+l];
        end
endgenerate

    assign outp[DW*4-1 : DW*3] = maxs[6];

endmodule
