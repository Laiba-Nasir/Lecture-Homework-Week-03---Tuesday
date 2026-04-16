`ifndef SHIFT_REGISTER_SV
`define SHIFT_REGISTER_SV

module shift_register #(
    // parameter list 
    // MSB = 1st, LSB =1st 
    parameter DIRECTION = 1
)(
    input wire clk,
    input wire rst,  // indicates shift register should be reset to all 0s
    input wire data,
    input wire wr_en,
    output reg [31:0] out
);

// alway blk that triggers on +ve egde 
// should handle reset and write enable based on DIRECTION 
always @(posedge clk) begin : blockName
    // handle reset and write enable 
    if (rst) begin
        out <= 32'b0; 
        
    end else if (wr_en) begin // u can only shift if write enable is high 

        if (DIRECTION == 1) begin
            // MSB shift 1st 1100 -> 1110
            // new bit entrs from MSB side / left side
            /*
            - drop right most bit 
            - shift eerything right by 1 --> by everything i mena, everything after dropping RMS out[31:1]
            - new bbit filles left most spot --> so pu tdata on left
            */

            out <= {data, out[31:1]};
            

            
        end else begin
            // LSB shift 1st 0011 -> 0111
            /*
                - drop leftmost bit 
                - shift everything left by 1
                - new bit fills the rightmost spot
            */

            
            out <= {out[30:0], data};
        end
        
    end


end


// shift logic 

endmodule

`endif