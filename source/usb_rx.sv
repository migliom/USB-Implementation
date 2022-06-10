// $Id: $
// File name:   usb_RX.sv
// Created:     4/20/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: get into it yuh

module usb_rx
(
    input wire clk, n_rst, dplus_in, dminus_in,
    input logic [6:0] buffer_occupancy,
    output logic rx_transfer_active, rx_error, flush, store_rx_packet_data, rx_data_ready,
    output logic [3:0] rx_packet,
    output logic [7:0] rx_packet_data
);

logic dplus_sync, dminus_sync, d_edge, d_orig, eop, shift_en, buff_en, byte_received;
logic [3:0] bit_cnt, count_bytes;
logic [7:0] temp_hold, rcv_fifo;
logic [15:0] buffer;
logic max_data_bytes_received;
logic clear_byte_received;

rx_sync_high sync_h(.clk(clk), .n_rst(n_rst), .async_in(dplus_in), .sync_out(dplus_sync));
    
rx_sync_low sync_l(.clk(clk), .n_rst(n_rst), .async_in(dminus_in), .sync_out(dminus_sync));

rx_edge_detector EDG (.clk(clk), .n_rst(n_rst), .dplus_sync(dplus_sync), .d_edge(d_edge));

rx_decoder dec(.clk(clk), .n_rst(n_rst), .rcving(rx_transfer_active), .dplus_sync(dplus_sync), .shift_en(shift_en), .d_orig(d_orig));

rx_timer tim(.clk(clk), .n_rst(n_rst), .receiving(rx_transfer_active), .packet_received(byte_received), .shift_en(shift_en), .max_data_received(max_data_bytes_received), .count_out_bit(count_bytes));

rx_flex_stp_sr #(8, 0) shift_register (.clk(clk), .n_rst(n_rst), .serial_in(d_orig), .shift_enable(shift_en), .parallel_out(temp_hold));

always_ff @( posedge clk, negedge n_rst ) begin : blockName
    if(!n_rst) rcv_fifo <= '1;
    else if(byte_received) rcv_fifo <= temp_hold;
end
//assign rcv_fifo = byte_received ? temp_hold : rcv_fifo;
//assign byte_received = clear_byte_received ? 1'b0 : byte_received;

rx_eop_detector eop_detec (.clk(clk), .n_rst(n_rst), .dplus_sync(dplus_sync), .dminus_sync(dminus_sync), .receiving(rx_transfer_active), .eop(eop));

rx_rcu state(.clk(clk), .n_rst(n_rst), .eop(eop), .byte_received(byte_received), .d_edge(d_edge), .rcv_data(rcv_fifo), .flush(flush), .rx_error(rx_error), .max_bytes_received(max_data_bytes_received),
                    .store_rx_packet_data(store_rx_packet_data), .rx_packet_data(rx_packet_data), 
                    .rx_data_ready(rx_data_ready), .rx_packet(rx_packet), .rx_transfer_active(rx_transfer_active), .buffer_occupancy(buffer_occupancy), .clear_byte_received(clear_byte_received),
                    .count_bytes(count_bytes));

endmodule