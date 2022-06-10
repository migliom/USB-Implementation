// $Id: $
// File name:   tx_timer.sv
// Created:     4/21/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: Timer block for tx module

module tx_timer
(
    input logic clk, n_rst,
    input logic clear_timer, enable_timer,
    output logic next_byte, shift_enable, new_bit, load_enable
);
    logic [3:0] bit_cycle_count;

    assign shift_enable = bit_cycle_count == 4'd7 ? 1'b1 : 1'b0;

    flex_counter_tx bit_period_tracker
    (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_timer),
        .count_enable(enable_timer),
        .rollover_val(4'd8),
        .count_out(bit_cycle_count),
        .rollover_flag(new_bit)
    );
    logic [6:0] byte_count_out;
    assign load_enable = byte_count_out == 7'd63 ? 1'b1 : 1'b0;
    assign next_byte = byte_count_out == 7'd62 ? 1'b1 : 1'b0;
    flex_counter_tx #(.NUM_CNT_BITS(3'd7)) byte_complete_tracker
    (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_timer),
        .count_enable(enable_timer),
        .rollover_val(7'd64),
        .count_out(byte_count_out)
    );

endmodule
