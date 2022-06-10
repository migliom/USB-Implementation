// $Id: $
// File name:   flex_counter.sv
// Created:     2/1/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: A flex counter
module flex_counter_tx 
#(
    parameter NUM_CNT_BITS = 4
)
(
    input logic clk, n_rst, clear, count_enable,
    input logic [(NUM_CNT_BITS-1):0] rollover_val,
    output logic [(NUM_CNT_BITS-1):0] count_out,
    output logic rollover_flag
);
    logic next_flag;
    logic [(NUM_CNT_BITS-1):0] next_count;
    
    always_ff @(posedge clk, negedge n_rst) begin : FF_FLEX_COUNTER
        if (n_rst == 1'b0) begin
            count_out <= 'b0;
            rollover_flag <= 1'b0;
        end
        else begin
            if (clear == 1'b1) begin
                count_out <= 'b0;
                rollover_flag <= 1'b0;
            end
            else if (count_enable == 1'b1) begin
                count_out <= next_count;
                rollover_flag <= next_flag;
            end
        end
    end
    always_comb begin
        next_flag = 1'b0;
        if (count_out == rollover_val) begin
            next_count = (NUM_CNT_BITS)'(1'b1);
        end
        else if (count_out == rollover_val - 1) begin
            next_count = count_out + 1;
            next_flag = 1'b1;
        end
        else begin
            next_count = count_out + 1;
        end
    end
endmodule
