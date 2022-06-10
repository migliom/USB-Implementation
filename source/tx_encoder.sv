// $Id: $
// File name:   tx_encoder.sv
// Created:     4/21/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: encoder module for tx module

module tx_encoder
(
    input logic clk, n_rst,
    input logic serial_out, new_bit, initiate, send_eop,
    output logic Dplus_out, Dminus_out, eop_done
);
    logic next_dp, next_dm;
    typedef enum logic [2:0] { NORMAL, P_EOP=4, EOP2, EOP3, IDLE} stateType;
    stateType state, next_state;

    always_ff @( posedge clk, negedge n_rst ) begin : REG
        if (n_rst == 1'b0) begin
            Dplus_out <= 1'b1; //Reset is 1
            Dminus_out <= 1'b0;
            state <= NORMAL;
        end
        else begin
            Dplus_out <= next_dp;
            Dminus_out <= next_dm;
            state <= next_state;
        end
    end
    always_comb begin : NEXT_STATE
        next_state = state;
        case (state)
            NORMAL: begin
                if (send_eop == 1'b1) begin
                    next_state = P_EOP;
                end
            end 
            P_EOP: begin
                if (new_bit == 1'b1) begin
                    next_state = EOP2;
                end
            end
            EOP2: begin
                if (new_bit == 1'b1) begin
                    next_state = EOP3;
                end
            end
            EOP3: begin
                if (new_bit == 1'b1) begin
                    next_state = IDLE;
                end
            end
            IDLE: begin
                if (new_bit == 1'b1) begin
                    next_state = NORMAL;
                end
            end
        endcase
    end
    always_comb begin : NEXT_DP_LOGIC
        next_dp = Dplus_out;
        next_dm = Dminus_out;
        eop_done = 0;
        case (state) 
            IDLE: begin
                next_dp = 1;
                next_dm = 0;
                if (new_bit == 1'b1) begin
                    eop_done = 1;
                end
            end
            NORMAL: begin
                if (new_bit == 1'b1 || initiate == 1'b1) begin
                    if (serial_out == 1'b0) begin
                        next_dp = ~Dplus_out;
                        next_dm = ~Dminus_out;
                    end
                end
            end
            P_EOP: begin
                if (new_bit == 1'b1) begin
                    next_dp = 0;
                    next_dm = 0;
                end
            end
            EOP2: begin
                next_dp = 0;
                next_dm = 0;
            end
            EOP3: begin
                if (new_bit == 1'b1) begin
                    next_dp = 1;
                    next_dm = 0;
                end
                else begin
                    next_dp = 0;
                    next_dm = 0;
                end
            end
        endcase
    end

endmodule
