// $Id: $
// File name:   decoder.sv
// Created:     4/20/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Decoder for the RX

module rx_decoder(
    input wire shift_en, clk, n_rst, dplus_sync, rcving,
    output logic d_orig
);

logic d_in1, d_in2, next_in1, next_in2; // Two consecutive bits on the input

always_ff @( posedge clk, negedge n_rst ) begin : FF
    if(!n_rst) begin
        d_in1 <= 1;
        d_in2 <= 0;
    end
    else if(rcving) begin
       d_in1 <= next_in1;
       d_in2 <= next_in2;
    end
end
 
always_comb begin : Next_Serial_Logic
    next_in1 = d_in1;
    next_in2 = d_in2;
    if (shift_en) begin
        next_in1 = dplus_sync;
        next_in2 = d_in1;
    end
end

    // Output logic
assign d_orig = ~(next_in1 ^ next_in2);

endmodule
