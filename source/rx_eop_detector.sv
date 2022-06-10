// $Id: $
// File name:   eop_detector.sv
// Created:     4/20/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: yuh


module rx_eop_detector(
    input wire clk, n_rst, dplus_sync, dminus_sync, receiving,
    output wire eop
);


assign eop = (receiving && (dplus_sync == dminus_sync)) ? 1'b1 : 1'b0;

endmodule