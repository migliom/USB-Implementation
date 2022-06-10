// $Id: $
// File name:   tx_control_fsm.sv
// Created:     4/21/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: 
// Control FSM for TX module

module tx_control_fsm
(
    input logic clk, n_rst,
    input logic next_byte, eop_done,
    input logic [3:0] tx_packet,
    input logic [6:0] buffer_occupancy,
    output logic send_eop, manual_load, initiate,
    output logic [1:0] packet_select,
    output logic tx_transfer_active, tx_error, get_tx_packet_data, enable_timer, clear_timer
);

    localparam IDLE_P = 4'b0000 ;
    localparam DATA0_P = 4'b0011 ;
    localparam DATA1_P = 4'b1011;
    localparam ACK_P = 4'b0010;
    localparam NAK_P = 4'b1010;
    //Give specific values for states?
    typedef enum logic [3:0] { 
        IDLE,
        BUFF_CHECK,
        ERROR,
        ERROR_WAIT,
        SYNC_L,
        INITIATE,
        INITIATE_WAIT,
        PID_L,
        DATA_L,
        DATA_W,
        EOP,
        CLEAR,
        WAIT
    } stateType;

    stateType state, next_state;

    always_ff @( posedge clk, negedge n_rst ) begin : STATE
        if (n_rst == 1'b0) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always_comb begin : NEXT_STATE
        next_state = state;
        case (state)
            IDLE: begin
                case (tx_packet)
                    DATA0_P, DATA1_P: begin
                        next_state = BUFF_CHECK;
                    end
                    ACK_P, NAK_P: begin
                        next_state = SYNC_L;
                    end
                endcase
            end
            ERROR_WAIT: begin
                case (tx_packet)
                    DATA0_P, DATA1_P: begin
                        next_state = BUFF_CHECK;
                    end
                    ACK_P, NAK_P: begin
                        next_state = SYNC_L;
                    end
                endcase
            end
            ERROR: begin
                if (tx_packet == 0) begin
                    next_state = ERROR_WAIT;
                end
            end
            BUFF_CHECK: begin
                if (buffer_occupancy == 0) begin
                    next_state = ERROR;
                end
                else begin
                    next_state = SYNC_L;
                end
            end
            SYNC_L: begin
                next_state = INITIATE;
            end
            INITIATE: begin
                next_state = INITIATE_WAIT;
            end
            INITIATE_WAIT: begin
                if (next_byte == 1'b1) begin
                    next_state = PID_L;
                end
            end
            PID_L: begin
                if (next_byte == 1'b1) begin
                    case (tx_packet)
                        DATA0_P, DATA1_P: begin
                            next_state = DATA_L;
                        end
                        ACK_P, NAK_P: begin
                            next_state = EOP;
                        end
                    endcase
                end
            end
            DATA_L: begin
                next_state = DATA_W;
            end
            DATA_W: begin
                if (next_byte == 1'b1) begin
                    if (buffer_occupancy == 0) begin
                        next_state = EOP;
                    end
                    else begin
                        next_state = DATA_L;
                    end
                end
            end
            EOP: begin
                if (eop_done == 1'b1) begin
                    next_state = CLEAR;
                end
            end
            CLEAR: begin
                next_state = WAIT;
            end
            WAIT: begin
                if (tx_packet == 0) begin
                    next_state = IDLE;
                end
            end
        endcase
    end


    always_comb begin : OUTPUT_LOGIC
        send_eop = 0;
        manual_load = 0;
        initiate = 0;
        packet_select = '0;
        tx_transfer_active = 0;
        tx_error = 0;
        get_tx_packet_data = 0;
        enable_timer = 0;
        clear_timer = 0;
        case (state) 
            CLEAR: begin
                clear_timer = 1;
            end
            ERROR: begin
                tx_error = 1;
            end
            ERROR_WAIT: begin
                tx_error = 1;
            end
            BUFF_CHECK: begin
                tx_transfer_active = 1;
            end
            SYNC_L: begin
                tx_transfer_active = 1;
                manual_load = 1;
            end
            INITIATE: begin
                tx_transfer_active = 1;
                enable_timer = 1;
                initiate = 1;
            end
            INITIATE_WAIT: begin
                tx_transfer_active = 1;
                enable_timer = 1;
            end
            EOP: begin
                send_eop = 1;
                enable_timer = 1;
                tx_transfer_active = 1;
            end
            PID_L: begin
                packet_select = 2'd1;
                enable_timer = 1;
                tx_transfer_active = 1;
            end
            DATA_L: begin
                get_tx_packet_data = 1;
                packet_select = 2'd2;
                enable_timer = 1;
                tx_transfer_active = 1;
            end
            DATA_W: begin
                packet_select = 2'd2;
                enable_timer = 1;
                tx_transfer_active = 1;
            end
        endcase
    end

endmodule

