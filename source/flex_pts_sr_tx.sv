// $Id: $
// File name:   flex_pts_sr.sv
// Created:     2/10/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: Parallel to serial flex shift register

module flex_pts_sr_tx
#(
    parameter NUM_BITS = 4,
    parameter SHIFT_MSB = 1
)
(
    input logic clk, n_rst, shift_enable, load_enable,
    input logic [NUM_BITS-1:0] parallel_in,
    output logic serial_out
);
    logic [NUM_BITS-1:0] state, next_state;
    assign serial_out = SHIFT_MSB ? state[NUM_BITS-1] : state[0];

    always_ff @ (posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0) begin
            state <= '1;
        end
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        if (load_enable) begin
            next_state = parallel_in;
        end
        else if (shift_enable) begin
            if (SHIFT_MSB) begin
                next_state = {state[NUM_BITS-2:0], 1'b1};
            end
            else begin
                next_state = {1'b1, state[NUM_BITS-1:1]};
            end
        end
    end

endmodule
