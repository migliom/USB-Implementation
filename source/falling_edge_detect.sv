// $Id: $
// File name:   falling_edge_detect.sv
// Created:     4/26/2022
// Author:      Ansh Patel
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Falling edge detect
module falling_edge_detect (
    input wire clk, n_rst, dplus_sync,
    output wire d_edge
);

logic dplus_prev;

always_ff @( posedge clk, negedge n_rst ) begin : FF
    if(!n_rst) dplus_prev <= 1'b1;
    else dplus_prev <= dplus_sync;
end

assign d_edge = ~dplus_sync & dplus_prev;

endmodule
