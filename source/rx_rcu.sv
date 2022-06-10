// $Id: $
// File name:   rcu_rx.sv
// Created:     4/21/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: state machine for the rx


module rx_rcu(
    input wire clk, n_rst, eop, byte_received, d_edge, max_bytes_received,
    input wire [7:0] rcv_data,
    input wire [6:0] buffer_occupancy,
    input wire [3:0] count_bytes,
    output logic flush, store_rx_packet_data, rx_data_ready, rx_transfer_active, rx_error,
    output logic [7:0] rx_packet_data,
    output logic [3:0] rx_packet,
    output logic clear_byte_received
);

typedef enum logic [4:0] {DATA_SEND_NO_STORE, WAIT, IDLE, READ_SYNC, CHECK_SYNC, READ_PID, SEND_PID, ACK_NACK, FLUSH, TOKEN_D1, SEND_TOKEN1, TOKEN_D2, SEND_TOKEN2, NO_DATA, DATA_RECV, DATA_SEND, EOP_STATE, ERROR} state_type;

logic err_flag, next_err_flag;
state_type state, next_state;
localparam check_sync = 8'b10000000;
localparam IN = 4'b1001;
localparam OUT = 4'b0001;
localparam DATA0 = 4'b0011;
localparam DATA1 = 4'b1011;
localparam ACK = 4'b0010;
localparam NACK = 4'b1010;

always_ff @( posedge clk, negedge n_rst ) begin : FF2
    if(!n_rst) err_flag <= 1'b0;
    else err_flag <= next_err_flag;
end

always_ff @( posedge clk, negedge n_rst ) begin : FF
    
    if(!n_rst) 
         state <= IDLE;
    else
        state <= next_state;
end

always_comb begin : NEXT_STATE_LOGIC
    next_state = state;
    next_err_flag = err_flag;
    clear_byte_received = 1'b0;
    case (state)
        IDLE : begin
            if(d_edge) next_state = READ_SYNC;
            else next_state = IDLE;
        end 
        READ_SYNC : begin
            if(eop) next_state = ERROR;
            else if(byte_received) next_state = CHECK_SYNC;
            else next_state = READ_SYNC;
        end 
        CHECK_SYNC : begin
            if(eop) next_state = ERROR;
            else if(rcv_data == check_sync) begin 
                next_state = READ_PID;
                clear_byte_received = 1'b1;
            end
            else next_state = ERROR;
        end 
        READ_PID : begin
            if(eop) next_state = ERROR;
            else if(byte_received) next_state = SEND_PID;
            else next_state = READ_PID;
        end 
        SEND_PID : begin
            if(eop) next_state = ERROR;
            else begin 
                clear_byte_received = 1'b1;
                case (rcv_data[3:0])
                    ACK, NACK : next_state = ACK_NACK; //fix this
                    IN, OUT : next_state = TOKEN_D1;
                    DATA0, DATA1 : next_state = FLUSH; //send to flush
                    default: next_state = ERROR;
                endcase
            end
        end 

        ACK_NACK : begin
            if(eop) next_state = EOP_STATE;
            else next_state = ERROR;
        end

        NO_DATA : begin
           if(eop) next_state = EOP_STATE;
           else next_state = ERROR; 
        end 
        TOKEN_D1 : begin
            if(eop) next_state = ERROR;
            if(byte_received) next_state = SEND_TOKEN1;
            else next_state = TOKEN_D1;
        end 
        SEND_TOKEN1 : begin
            if(eop) next_state = ERROR;
            clear_byte_received = 1'b1;
            next_state = TOKEN_D2;
        end 
        TOKEN_D2 : begin
            if(eop) next_state = ERROR;
            if(byte_received) next_state = SEND_TOKEN2;
            else next_state = TOKEN_D2;
        end 
        SEND_TOKEN2 : begin
            if(eop) next_state = EOP_STATE;
            else next_state = WAIT;
            clear_byte_received = 1'b1;
        end 
        FLUSH : begin
            if(eop) next_state = ERROR;
            else next_state = DATA_RECV;
        end 
        DATA_RECV : begin
            if(eop || max_bytes_received) next_state = ERROR;
            else if(byte_received) next_state = DATA_SEND;
            else next_state = DATA_RECV;
        end 
        DATA_SEND : begin
            if(eop) next_state = EOP_STATE;
            else if(~max_bytes_received && d_edge) begin
                next_state = DATA_RECV;
                clear_byte_received = 1'b1;
            end
            else begin 
                next_state = DATA_SEND_NO_STORE;
                clear_byte_received = 1'b1;
            end
        end 

        WAIT : begin
            if(eop) next_state = EOP_STATE;
            else next_state = WAIT;
        end

        DATA_SEND_NO_STORE: begin
            if(eop && count_bytes != 4'd8) next_state = ERROR;
            else if(eop) next_state = EOP_STATE;
            else if(max_bytes_received && d_edge) next_state = ERROR;
            else if(max_bytes_received && byte_received) next_state = ERROR;
            // else if(~max_bytes_received && d_edge) begin
            //     next_state = DATA_RECV;
            //     clear_byte_received = 1'b1;
            // end
            else if(~max_bytes_received && byte_received) begin
                next_state = DATA_SEND;
                clear_byte_received = 1'b1;
            end
            else next_state = DATA_SEND_NO_STORE;
        end
        EOP_STATE : begin
            if(d_edge) next_state = IDLE;
            else next_state = EOP_STATE;
        end 
        ERROR : begin
            if(eop) next_state = EOP_STATE;
            else next_state = ERROR;
        end 
        
        default: next_state = IDLE;
    endcase

    if(next_state == ERROR) next_err_flag = 1'b1;
    else if(next_state == READ_SYNC) next_err_flag = 1'b0;

end

always_comb begin : state_logic
        rx_transfer_active = 1'b0;
        rx_error = err_flag;
        flush = 1'b0;
        rx_data_ready = 1'b0;
        store_rx_packet_data = 1'b0;
        rx_transfer_active = 1'b0;
        rx_packet = '0;
        rx_packet_data = '0;
        case (state)
            IDLE : begin
                rx_transfer_active = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            READ_SYNC : begin
                rx_transfer_active = 1'b1;
                //rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            CHECK_SYNC : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            READ_PID : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            SEND_PID : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                rx_packet = rcv_data[3:0];
                //rx_packet_data = '1;
            end 

            ACK_NACK : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                rx_packet = rcv_data[3:0];
            end

            NO_DATA : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            TOKEN_D1 : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            SEND_TOKEN1 : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b1;
                //rx_packet = '1;
                rx_packet_data = rcv_data;
            end 
            TOKEN_D2 : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            SEND_TOKEN2 : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b1;
                store_rx_packet_data = 1'b1;
                //rx_packet = '1;
                rx_packet_data = rcv_data;
            end 
            FLUSH : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b1;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            DATA_RECV : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            DATA_SEND : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b1;
                store_rx_packet_data = 1'b1;
                //rx_packet = '1;
                rx_packet_data = rcv_data;
            end 

            DATA_SEND_NO_STORE: begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                rx_packet_data = rcv_data;
            end
            EOP_STATE : begin
                rx_transfer_active = 1'b0;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            WAIT : begin
                rx_transfer_active = 1'b1;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
            ERROR : begin
                rx_transfer_active = 1'b1;
                rx_error = 1'b1;
                flush = 1'b0;
                rx_data_ready = 1'b0;
                store_rx_packet_data = 1'b0;
                //rx_packet = '1;
                //rx_packet_data = '1;
            end 
    endcase
end
endmodule