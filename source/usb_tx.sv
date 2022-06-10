// $Id: $
// File name:   usb_tx.sv
// Created:     4/21/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: Top module for USB TX module

module usb_tx
(
    input logic clk, n_rst,
    input logic [3:0] tx_packet,
    input logic [6:0] buffer_occupancy,
    input logic [7:0] tx_packet_data,
    output logic tx_transfer_active, tx_error, get_tx_packet_data, Dplus_out, Dminus_out
);
    logic next_byte; 
    logic eop_done;
    logic send_eop;
    logic manual_load;
    logic initiate;
    logic [1:0] packet_select;
    logic enable_timer;
    logic clear_timer;
    tx_control_fsm TX_CONTROL_FSM
    (
        .clk(clk),
        .n_rst(n_rst),
        .next_byte(next_byte),
        .eop_done(eop_done),
        .tx_packet(tx_packet),
        .buffer_occupancy(buffer_occupancy),
        .send_eop(send_eop),
        .manual_load(manual_load),
        .initiate(initiate),
        .packet_select(packet_select),
        .tx_transfer_active(tx_transfer_active),
        .tx_error(tx_error),
        .get_tx_packet_data(get_tx_packet_data),
        .enable_timer(enable_timer),
        .clear_timer(clear_timer)
    );
    logic shift_enable;
    logic new_bit;
    logic load_enable;
    tx_timer TX_TIMER
    (
        .clk(clk),
        .n_rst(n_rst),
        .clear_timer(clear_timer),
        .enable_timer(enable_timer),
        .next_byte(next_byte),
        .shift_enable(shift_enable),
        .new_bit(new_bit),
        .load_enable(load_enable)
    );
    logic serial_out;
    tx_encoder TX_ENCODER
    (
        .clk(clk),
        .n_rst(n_rst),
        .serial_out(serial_out),
        .new_bit(new_bit),
        .initiate(initiate),
        .send_eop(send_eop),
        .Dplus_out(Dplus_out),
        .Dminus_out(Dminus_out),
        .eop_done(eop_done)
    );
    logic [7:0] parallel_in;
    tx_shift_register TX_SHIFT_REGISTER
    (
        .clk(clk),
        .n_rst(n_rst),
        .parallel_in(parallel_in),
        .load_enable(load_enable),
        .shift_enable(shift_enable),
        .manual_load(manual_load),
        .serial_out(serial_out)
    );
    logic [7:0] pid_byte;
    tx_pid_byte TX_PID_BYTE
    (
        .tx_packet(tx_packet),
        .pid_byte(pid_byte)
    );
    logic [7:0] sync_byte;
    tx_sync_byte TX_SYNC_BYTE
    (
        .sync_byte(sync_byte)
    );
    tx_mux TX_MUX
    (
        .sync_byte(sync_byte),
        .pid_byte(pid_byte),
        .tx_packet_data(tx_packet_data),
        .packet_select(packet_select),
        .parallel_in(parallel_in)
    );

endmodule
