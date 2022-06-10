// $Id: $
// File name:   edge_detector.sv
// Created:     4/20/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Edge detector .


module rx_edge_detector (
    input wire clk, n_rst, dplus_sync,
    output wire d_edge
);

logic dplus_prev;

always_ff @( posedge clk, negedge n_rst ) begin : FF
    if(!n_rst) dplus_prev <= 1'b1;
    else dplus_prev <= dplus_sync;
end

assign d_edge = dplus_sync == ~dplus_prev;

endmodule