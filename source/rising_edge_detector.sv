// $Id: $
// File name:   rising_edge_detector.sv
// Created:     4/27/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: ridsing edge
module rising_edge_detector (
    input wire clk, n_rst, dplus_sync,
    output wire d_edge
);

logic dplus_prev;

always_ff @( posedge clk, negedge n_rst ) begin : FF
    if(!n_rst) dplus_prev <= 1'b1;
    else dplus_prev <= dplus_sync;
end

assign d_edge = dplus_sync & ~dplus_prev;

endmodule