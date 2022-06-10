// $Id: $
// File name:   tx_shift_register.sv
// Created:     4/21/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: shift register for tx module

module tx_shift_register
(
    input logic clk, n_rst,
    input logic [7:0] parallel_in,
    input logic load_enable, shift_enable, manual_load,
    output logic serial_out
);
    logic load;
    assign load = manual_load | load_enable;
    flex_pts_sr_tx #(.NUM_BITS(8), .SHIFT_MSB(0)) pts_shift_reg 
    (
        .clk(clk),
        .n_rst(n_rst),
        .shift_enable(shift_enable),
        .load_enable(load),
        .parallel_in(parallel_in),
        .serial_out(serial_out)
    );
endmodule
