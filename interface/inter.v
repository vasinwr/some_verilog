// StreamLoopback128.v
// Copyright 2010 Pico Computing, Inc.
/* This module illustrates the use of the streams interface between a PC host and
   the Pico Card. The kernel of this module echoes back the input data.
*/



module inter 
  #(parameter 
num_bits=127)

(
    // The clk and rst signals are shared between all the streams in this module,
    //   which are: stream #1 in, and stream #1 out.
    input               clk,
    input               rst,
    
    // These are the signals for stream #1 INto the firmware.
    input               s1i_valid,
    output              s1i_rdy,
    input [127:0]       s1i_data,
    
    // These are the signals for stream #1 OUT of the firmware.
    output reg          s1o_valid,
    input               s1o_rdy,
    output [127:0]      s1o_data
    );
    
    //////////////////////
    // STREAMING SYSTEM //
    //////////////////////
    
    /*
     *  --------------                   -------------                   ---------------
     * |              | -> s1i_valid -> |             | -> s1o_valid -> |               |
     * | INPUT STREAM | -> s1i_data  -> | THIS MODULE | -> s1o_data  -> | OUTPUT STREAM |
     * |              | <- s1i_rdy   <- |             | <- s1o_rdy   <- |               |
     *  --------------                   -------------                   ---------------
     */
    
    //////////////    
    // DATAPATH //
    //////////////
    
    // this is a running sum of the input stream.
    reg [31:0]  sum;
    // this is a copy of the low 32 bits of the last input value, because we want to echo it.
    reg [31:0]  last_input;

    // the output data is a concatenation of the current sum, the last input value, and a signature.
    assign s1o_data = {32'h42424242, 32'hdeadbeef, sum[31:0], last_input[31:0]};
    
    // all we are doing is computing a checksum on the input data (sum) and 
    // registering the piece of input data that we just received (last_input) 
    // so we can echo it back to the output stream
    always @(posedge clk) begin
        if (rst) begin
            sum         <= 0;
        end else if (s1i_valid && s1i_rdy) begin
            sum         <= sum + s1i_data[31:0];
            last_input  <= s1i_data[31:0];
        end
    end
    
    /////////////    
    // CONTROL //
    /////////////
    
    // we can accept new data from the input stream if the output stream is 
    // accepting our current data (s1o_rdy == 1), or our pipeline register does 
    // not currently hold valid data (s1o_valid == 0)
    assign s1i_rdy = ~s1o_valid | s1o_rdy;
    
    // we hold valid data (which we registered from the input) at the output 
    // until it is accepted by the output (s1o_rdy == 1)
    // we know we just grabbed valid data from the input if the input valid 
    // signal is asserted (s1i_valid == 1)
    always @(posedge clk) begin
        if (rst) begin
            s1o_valid   <= 0;
        end else if (s1i_rdy) begin
            s1o_valid   <= s1i_valid;
        end 
    end

endmodule


