// $Id: $
// File name:   tx_sync_byte.sv
// Created:     4/21/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: sync byte output for tx module

module tx_sync_byte
(
    output logic [7:0] sync_byte
);
    assign sync_byte = 8'b10000000;
endmodule
