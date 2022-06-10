// $Id: $
// File name:   tx_mux.sv
// Created:     4/21/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: mux that controls inputs to shift register

module tx_mux
(
    input logic [7:0] sync_byte, pid_byte, tx_packet_data,
    input logic [1:0] packet_select,
    output logic [7:0] parallel_in
);

    always_comb begin
        case (packet_select)
            2'd0: begin
                parallel_in = sync_byte;
            end 
            2'd1: begin
                parallel_in = pid_byte;
            end
            2'd2: begin
                parallel_in = tx_packet_data;
            end
            default: begin
                // Default for value 2'd3
                parallel_in = sync_byte;
            end
        endcase
    end
endmodule
