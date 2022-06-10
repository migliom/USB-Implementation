// $Id: $
// File name:   flex_counter.sv
// Created:     2/9/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Flex Counter for lab4, it needs to be quick!

module rx_flex_counter #(
    parameter NUM_CNT_BITS = 4
)
(
    input wire clk,
    input wire n_rst,
    input wire clear,
    input wire count_enable,
    input reg[NUM_CNT_BITS-1:0] rollover_val,
    output reg [NUM_CNT_BITS-1:0] count_out,
    output reg rollover_flag
);

reg [NUM_CNT_BITS-1:0] next_count;
reg next_rollover_flag;
always_ff @(posedge clk, negedge n_rst) 
begin
    if(n_rst == 1'b0) begin
        rollover_flag <= 1'b0;
        count_out <= '0;
    end 
    else begin
        rollover_flag <= next_rollover_flag;
        count_out <= next_count;
    end
end


always_comb begin
    //prevent latch
    next_count = count_out;
    next_rollover_flag = rollover_flag;
    if(clear == 1'b1) begin
        next_count = '0;
        next_rollover_flag = 1'b0;
    end 
    else begin
        if(count_enable == 1'b1) begin
            if(count_out == (rollover_val-1)) begin
                next_count = next_count + 1;
                next_rollover_flag = 1'b1;
            end
            else if(rollover_flag == 1'b1) begin
                next_count = {{{NUM_CNT_BITS-1}{1'b0}}, 1'b1};
                next_rollover_flag = 1'b0;
            end
            else 
                next_count = next_count + 1;
        end
    end
end
endmodule
