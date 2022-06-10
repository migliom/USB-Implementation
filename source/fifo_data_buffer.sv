// $Id: $
// File name:   fifo_data_buffer.sv
// Created:     4/20/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: 64 byte FIFO data buffer with no pointer wrapping or overflow protection

`timescale 1ns/10ps


//NOTE: if gets occur before posedge, then pointers WILL Increment


module fifo_data_buffer
(
    input logic clear, flush, 
    input logic clk, n_rst, 
    input logic store_tx_data, store_rx_packet_data, 
    input logic get_rx_data, get_tx_packet_data,
    input logic [7:0] tx_data, rx_packet_data,
    output logic [7:0] rx_data, tx_packet_data,
    output logic [6:0] buffer_occupancy
);

    logic s_reset;
    
    logic [7:0] wdata;
    logic [6:0] wpointer, n_wp;
    logic w_en;

    logic [7:0] rdata;
    logic [6:0] rpointer, n_rp;
    logic r_en;

    logic [7:0] registers [63:0];
     
    // BUFFER OCCUPANCY 
    logic [6:0] next_buffer_occupancy;
    always_ff @( posedge clk, negedge n_rst ) begin : BUFFER_OCCUPANCY
        if (n_rst == 1'b0) begin
            buffer_occupancy <= '0;
        end
        else if (s_reset) begin
            buffer_occupancy <= '0;
        end
        else begin
            buffer_occupancy <= next_buffer_occupancy;
        end
    end
    always_comb begin
        if (w_en && !r_en) begin
            next_buffer_occupancy = buffer_occupancy+1;
        end
        else if (r_en && !w_en) begin
            next_buffer_occupancy = buffer_occupancy-1;
        end
        else begin
            next_buffer_occupancy = buffer_occupancy;
        end
    end
    // MEMORY MODULE
    always_ff @( posedge clk, negedge n_rst ) begin : REGISTERS
        if (n_rst == 1'b0) begin
            rpointer <= '0;
            wpointer <= '0;
            registers <= '{
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00
                         };
        end
        else if (s_reset == 1'b1) begin
            rpointer <= '0;
            wpointer <= '0;
            registers <= '{
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
                          8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00
                         };

        end
        else if (w_en == 1'b1) begin
            registers[wpointer[5:0]] <= wdata;
            rpointer <= n_rp;
            wpointer <= n_wp;
        end
        else begin
            rpointer <= n_rp;
            wpointer <= n_wp;
        end
    end
    // Should rdata (or the read outputs) be registered and everything takes 1 extra cycle?
    always_comb begin
        rdata = '0;
        if (r_en == 1'b1) begin
            rdata = registers[rpointer[5:0]];
        end
    end

    // FLUSH CONTROLLER
    always_comb begin : FLUSH_CONTROLLER
        s_reset = 1'b0;
        if (clear == 1'b1) begin
            s_reset = 1'b1;
        end
        else if (flush == 1'b1) begin
            s_reset = 1'b1;
        end
    end

    // READ HANDLER
    always_comb begin : NEXT_READ_POINTER
        n_rp = rpointer;
        if (r_en) begin
            n_rp = rpointer + 1;
        end
    end
    always_comb begin : READ_INPUT_HANDLER
        rx_data = '0;
        tx_packet_data = '0;
        r_en = 0;
        if (get_tx_packet_data == 1'b1) begin
            tx_packet_data = rdata;
            r_en = 1;
        end
        else if (get_rx_data == 1'b1) begin
            rx_data = rdata;
            r_en = 1;
        end
    end
    // WRITE HANDLER
    always_comb begin : NEXT_WPOINTER
        n_wp = wpointer;
        if (w_en) begin
            n_wp = wpointer + 1;
        end
    end
    always_comb begin : WRITE_INPUT_HANDLER
        if (store_tx_data == 1'b1) begin
            wdata = tx_data;
            w_en = 1;
        end
        else if (store_rx_packet_data) begin
            wdata = rx_packet_data;
            w_en = 1;
        end
        else begin
            wdata = '0;
            w_en = 0;
        end
    end

endmodule
