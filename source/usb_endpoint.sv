// $Id: $
// File name:   usb_endpoint.sv
// Created:     4/25/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: USB Full-Speed endpoint AHB-lite slave SOC module .
// 

module usb_endpoint
(
    input logic clk,
    input logic n_rst,
    input logic hsel,
    input logic [3:0] haddr,
    input logic [1:0] htrans,
    input logic [1:0] hsize,
    input logic hwrite,
    input logic [31:0] hwdata,
    input logic dplus_in,
    input logic dminus_in,
    output logic [31:0] hrdata,
    output logic hresp,
    output logic hready,
    output logic d_mode,
    output logic dplus_out,
    output logic dminus_out
);

    logic [3:0] rx_packet;
    logic rx_data_ready,rx_transfer_active,tx_transfer_active,rx_error,flush;
    logic [6:0] buffer_occupancy;
    logic [7:0] rx_data;
    logic get_rx_data,store_tx_data;
    logic [7:0] tx_data;
    logic clear;
    logic [7:0] tx_packet_data;
    logic [3:0] tx_packet;
    logic tx_error;
    logic get_tx_packet_data;
    logic store_rx_packet_data;
    logic [7:0] rx_packet_data;

    ahb_slave
    SLAVE(
        .clk(clk),
        .n_rst(n_rst),
        .hsel(hsel),
        .hwrite(hwrite),
        .htrans(htrans),
        .hsize(hsize),
        .haddr(haddr),
        .hwdata(hwdata),
        .rx_data(rx_data),
        .rx_data_ready(rx_data_ready),
        .rx_transfer_active(rx_transfer_active),
        .rx_error(rx_error),
        .tx_transfer_active(tx_transfer_active),
        .tx_error(tx_error),
        .rx_packet(rx_packet),
        .buffer_occupancy(buffer_occupancy),
        .tx_data(tx_data),
        .store_tx_data(store_tx_data),
        .get_rx_data(get_rx_data),
        .hready(hready),
        .hresp(hresp),
        .tx_packet(tx_packet),
        .clear(clear),
        .hrdata(hrdata),
        .d_mode(d_mode)
    );

    fifo_data_buffer
    FIFO_BUFFER(
        .clear(clear),
        .flush(flush), 
        .clk(clk),
        .n_rst(n_rst), 
        .store_tx_data(store_tx_data),
        .store_rx_packet_data(store_rx_packet_data), 
        .get_rx_data(get_rx_data),
        .get_tx_packet_data(get_tx_packet_data),
        .tx_data(tx_data),
        .rx_packet_data(rx_packet_data),
        .rx_data(rx_data),
        .tx_packet_data(tx_packet_data),
        .buffer_occupancy(buffer_occupancy)
    );

    usb_tx
    TX_USB(
        .clk(clk),
        .n_rst(n_rst),
        .tx_packet(tx_packet),
        .buffer_occupancy(buffer_occupancy),
        .tx_packet_data(tx_packet_data),
        .tx_transfer_active(tx_transfer_active),
        .tx_error(tx_error),
        .get_tx_packet_data(get_tx_packet_data),
        .Dplus_out(dplus_out),
        .Dminus_out(dminus_out)
    );

    usb_rx
    RX_USB(
        .clk(clk),
        .n_rst(n_rst),
        .dplus_in(dplus_in),
        .dminus_in(dminus_in),
        .buffer_occupancy(buffer_occupancy),
        .rx_transfer_active(rx_transfer_active),
        .rx_error(rx_error),
        .flush(flush),
        .store_rx_packet_data(store_rx_packet_data),
        .rx_data_ready(rx_data_ready),
        .rx_packet(rx_packet),
        .rx_packet_data(rx_packet_data)
    );

endmodule