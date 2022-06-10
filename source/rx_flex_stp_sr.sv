// $Id: $
// File name:   flex_stp_sr.sv
// Created:     2/10/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: This si the serial to parallel flex 

module rx_flex_stp_sr #(
    parameter NUM_BITS = 8,
    parameter SHIFT_MSB = 0
)
(
  input wire clk,
  input wire n_rst,
  input wire serial_in,
  input wire shift_enable,
  output reg [NUM_BITS-1:0] parallel_out 
);

reg[NUM_BITS-1:0] next_data;
always_ff @(posedge clk, negedge n_rst) begin : FF
    if(n_rst == 1'b0) begin
        parallel_out <= '1;
    end
    else
        parallel_out <= next_data;
end

always_comb begin : Next_State

    next_data = parallel_out;
    if(shift_enable) begin
        if(!SHIFT_MSB) //left to right
            next_data = {serial_in, parallel_out[NUM_BITS-1:1]};
        else
            next_data = {parallel_out[NUM_BITS-2:0], serial_in};
    end
end

endmodule