// $Id: $
// File name:   timer.sv
// Created:     3/1/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: This module will keep track of the timing of the serial_in data line


module rx_timer(
    input wire clk, n_rst, receiving,
    output logic shift_en, packet_received, max_data_received,
    output logic [3:0] count_out_bit
);
    logic rollover_flag;

    localparam num_bits = 4;
    logic [num_bits-1:0] count_out_10bit;
    rx_flex_counter #(num_bits) ten_bit_count(
                    .clk(clk), 
                    .n_rst(n_rst), 
                    .clear(!receiving), 
                    .count_enable(receiving), 
                    .rollover_val(4'd8), 
                    .count_out(count_out_10bit)
                    //.rollover_flag(shift_en)
    );
    assign shift_en = count_out_10bit == 4'd3 ? 1'b1 : 1'b0;
    logic [num_bits-1:0] count_out_8bit;
    rx_flex_counter #(num_bits) nine_bit_count(
                    .clk(clk), 
                    .n_rst(n_rst), 
                    .clear(!receiving), 
                    .count_enable(shift_en), 
                    .rollover_val(4'd8), 
                    .count_out(count_out_8bit), 
                    .rollover_flag(rollover_flag)
    );
    rising_edge_detector rise (.clk(clk), .n_rst(n_rst), .dplus_sync(rollover_flag), .d_edge(packet_received) );
    assign count_out_bit = count_out_8bit;
    logic [6:0] count_out_64bytes;
    rx_flex_counter #(7) six_four_byte_count(
                    .clk(clk), 
                    .n_rst(n_rst), 
                    .clear(!receiving), 
                    .count_enable(packet_received), 
                    .rollover_val(7'd66), 
                    .count_out(count_out_64bytes), 
                    .rollover_flag(max_data_received)
    );
endmodule