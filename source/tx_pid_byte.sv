// $Id: $
// File name:   tx_pid_byte.sv
// Created:     4/21/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: pid_byte calculate for tx module

module tx_pid_byte
(
    input logic [3:0] tx_packet,
    output logic [7:0] pid_byte
);
    //Writing a ’1’ value to this register causes the design to send a Data
    //packet, if enough data is present in the data buffer.
    //Writing a ’2’ value to this register causes the design to send an ’ACK’.
    //Writing a ’3’ value to this register causes the design to send an ’NAK’.
    //Writing a ’4’ value to this register causes the design to send an ’STALL’.
    //      A '4' is ignored
    // IDLE = 4'b0000 ;
    // DATA0 = 4'b0011 ;
    // DATA1 = 4'b1011 ; Not used
    // ACK = 4'b0010;
    // NAK = 4'b1010;
    // STALL = 4'b1110 ; Not used

    localparam IDLE = 4'b0000 ;
    localparam DATA0 = 4'b0011 ;
    localparam DATA1 = 4'b1011;
    localparam ACK = 4'b0010;
    localparam NAK = 4'b1010;
    always_comb begin 
        pid_byte = {~tx_packet, tx_packet};
    end


endmodule
