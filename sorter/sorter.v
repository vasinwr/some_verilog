module sorter
    #(parameter
        N = 5,
        DW = 8
    )
    (
        input wire [(DW*N) -1 :0] inp,
        output wire [(DW*N) -1 :0] outp
    );

    localparam total_cmp = (N)*(N-1)/2 ;  //total number of comparators needed

    genvar i,j, n;
    wire [DW-1 :0] mins[1:total];  //intermediate results, index starts from 1
    wire [DW-1 :0] maxs[1:total];

    //unbalance
    module comparator #(.DW(DW)) cmp (.inp1(inp[DW*N-1: DW*(N-1)]), inp2(DW*(N-1)-1 : DW*(N-2)), out_min.(mins[1]), out_max(maxs[1]));
    generate 
        //top row
        for (k = 2; k < N-1; k = k + 1) begin imbalance:
            module comparator #(.DW(DW)) cmp (.inp1(mins[k-1]), .inp2(inp[DW*(N-k)-1: DW*(N-k-1)]), out_min(mins[k]), out_max(max[k]));
        end
        n = k; //4
        for (i = 2; i <= N-1; i = i + 1) begin: rows
            n = n + 1;
            module comparator #(.DW(DW)) cmp (.inp1(maxs[n-(N-i)-j]), .inp2(maxs[n-(N-i)-j+1]), .out_min(mins[n]), .out_max(maxs[n]));
            for (j=2; j <= N-i; j = j+1 ) begin : columns  
                n = n + 1;
                module comparator #(.DW(DW)) cmp (.inp1(mins[n-1]), .inp2(maxs[n-(N-i)-j+1), .out_min(mins[n]), .out_max(maxs[n]));  
            end
        end
    endgenerate

    // TODO 
    assign output 

endmodule
