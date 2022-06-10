// $Id: $
// File name:   sync_low.sv
// Created:     2/3/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 2 Flip Flop synchronizer from lab 1


module rx_sync_low ( 
    input wire clk,
    input wire n_rst,
    input wire async_in,
    output logic sync_out
);
logic temp;
always_ff @(posedge clk, negedge n_rst)
begin
    if(n_rst == 1'b0) begin
        sync_out <= 1'b0;
        temp <= 1'b0;
    end
    else begin
        temp <= async_in;
        sync_out <= temp;
    end
end

endmodule