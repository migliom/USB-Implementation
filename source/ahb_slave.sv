// $Id: $
// File name:   ahb_slave.sv
// Created:     4/18/2022
// Author:      Ansh Patel
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: AHB-Lite-Slave module

module ahb_slave
(
    input logic clk,n_rst,
    input logic hsel,hwrite,
    input logic [1:0] htrans,hsize,
    input logic [3:0] haddr,
    input logic [31:0] hwdata,
    input logic [7:0]rx_data,
    input logic rx_data_ready,
    input logic rx_transfer_active,rx_error,
    input logic tx_transfer_active,tx_error,
    input logic [3:0] rx_packet,
    input logic [6:0] buffer_occupancy,
    output logic [7:0] tx_data,
    output logic store_tx_data,get_rx_data,
    output logic hready,hresp,
    output logic [3:0] tx_packet,
    output logic clear,
    output logic [31:0] hrdata,
    output logic d_mode
);

    //DEFINE ADDRESS INDEX VALUES
    localparam DATA = 0;
    localparam STATUS = 4;
    localparam ERROR = 6;
    localparam B_OCCUPY = 8;
    localparam FLUSH = 10;

    //MAKING BUFFER REGISTERS
    logic [3:0] [7:0] mem,nxt_mem;

    //HTRANS
    localparam TRANS_IDLE = 2'b00;
    localparam TRANS_NON = 2'b10;

    //PACKET TYPES
    localparam OUT = 4'b0001;
    localparam IN = 4'b1001;
    localparam DATA0 = 4'b0011;
    localparam DATA1 = 4'b1011;
    localparam ACK = 4'b0010;
    localparam NAK = 4'b1010;
    localparam STALL = 4'b1110;

    logic [3:0] read_select;
    logic [3:0] write_select;
    logic [3:0] haddr_f;
    logic hwrite_f;
    logic [1:0] hsize_f,htrans_f;
    logic [31:0] nxt_hrdata;
    logic hazard;
    logic [3:0] x,tx_pac,nxt_tx_pac;
    logic flush_ctrl,nxt_flush_ctrl;

    logic tx_transfer_active_falling_edge;
    //FLOP HSIZE, HADDR, HWRITE
    always_ff @(posedge clk,negedge n_rst) begin : FLOP_AHB_SIGNALS
        if (!n_rst)
        begin
            hsize_f <= '0;
            hwrite_f <= '0;
            haddr_f <= '0;
            htrans_f <= '0;
        end
        else
        begin
            hsize_f <= hsize;
            hwrite_f <= hwrite;
            haddr_f <= haddr;
            htrans_f <= htrans;
        end
    end

    //RAW HAZARD CASE
    assign hazard = ((!hwrite && hwrite_f) && (haddr_f == haddr)) ? 1'b1 : 1'b0;

    //REGISTER WRITE SELECT
    always_ff @(posedge clk,negedge n_rst) begin : REG_WRITE_SEL
        if (!n_rst)
            write_select <= '0;
        else
            write_select <= read_select;
    end

    //ADDRESS MAPPING
    always_comb begin : ADD_MAP
        read_select = write_select;
        //hresp = 1'b0;
        if (hsel)
        begin
            if ((hwrite == 1) && (haddr<9) && (haddr>3) || (hsize == 3) || (haddr>13) || (haddr==9) || (haddr==10) || (haddr==11)) begin//HRESP ERROR
                //hresp = 1'b1;
            end
            else //NORMAL CASE
            begin
                case (hsize)
                    2'b00: read_select = haddr;
                    2'b01: read_select = haddr >> 1 << 1; //ignore 1 LSB
                    2'b10: read_select = haddr >> 2 << 2; //ignore 2 LSB
                endcase
            end
        end
    end

    //REGISTER HRDATA
    always_ff @(posedge clk,negedge n_rst) begin : REG_HRDATA
        if (!n_rst)
            hrdata <= '0;
        else
            hrdata <= nxt_hrdata;
    end

    logic [31:0] nxt_stat,stat,nxt_er,er;
    logic [6:0] bo;

    //STATUS, ERR and BUFFER OCCUPANCY REGISTER

    always_ff @(posedge clk,negedge n_rst) begin : STATS_FLOP
        if (!n_rst)
        begin
            stat <= '0;
            er <= '0;
            bo <= '0;
            mem <= '0;
        end
        else
        begin
            stat <= nxt_stat;
            er <= nxt_er;
            bo <= buffer_occupancy;
            mem <= nxt_mem;
        end
    end

    always_comb begin : STATUS_LOGIC
        nxt_stat = stat;
        if (rx_data_ready == 1'b1)
            nxt_stat[0] = 1'b1;
        else
            nxt_stat[0] = 1'b0;
        if (rx_packet == 4'b1001)
            nxt_stat[1] = 1'b1;
        else
            nxt_stat[1] = 1'b0;
        if (rx_packet == 4'b0001)
            nxt_stat[2] = 1'b1;
        else
            nxt_stat[2] = 1'b0;
        if (rx_packet == 4'b0010)
            nxt_stat[3] = 1'b1;
        else
            nxt_stat[3] = 1'b0;
        if (rx_packet == 4'b1010)
            nxt_stat[4] = 1'b1;
        else
            nxt_stat[4] = 1'b0;
        if (rx_transfer_active == 1'b1)
            nxt_stat[8] = 1'b1;
        else
            nxt_stat[8] = 1'b0;
        if (tx_transfer_active == 1'b1)
            nxt_stat[9] = 1'b1;
        else
            nxt_stat[9] = 1'b0;
    end

    always_comb begin : EEROR_LOGIC
        nxt_er = er;
        if (rx_error == 1'b1)
            nxt_er[0] = 1'b1;
        else
            nxt_er[0] = 1'b0;
        if (tx_error == 1'b1)
            nxt_er[8] = 1'b1;
        else
            nxt_er[8] = 1'b0;
    end

    logic [2:0] nxt_read_rx,read_rx;
    logic clear_rx;

    //AHB SELECTING READ DATA
    always_comb begin : AHB_MUX

        if (clear_rx == 1'b1)
            nxt_read_rx = '0;
        else
        begin
            nxt_read_rx = read_rx;
        end
        
        //nxt_read_rx = read_rx;
        if ((hsel == 1) && (hwrite == 0) && (htrans == TRANS_NON))
        begin
            //if (hazard == 1)
            //begin
                //nxt_hrdata = hwdata;
            //end
            //else
            //begin
                case (hsize)
                    2'b00:
                    begin
                        case (haddr)
                            4'd0:
                            begin
                                //nxt_hrdata = {24'd0,mem[read_select]};
                                nxt_read_rx = 3'd1;
                            end
                            4'd1:
                            begin
                                //nxt_hrdata = {16'd0,mem[read_select],8'd0};
                                nxt_read_rx = 3'd1;
                            end
                            4'd2:
                            begin
                                //nxt_hrdata = {8'd0,mem[read_select],16'd0};
                                nxt_read_rx = 3'd1;
                            end
                            4'd3:
                            begin
                                //nxt_hrdata = {mem[read_select],24'd0};
                                nxt_read_rx = 3'd1;
                            end
                            //4'd4: nxt_hrdata = {24'd0,stat[7:0]};
                            //4'd5: nxt_hrdata = {16'd0,stat[15:8],8'd0};
                            //4'd6: nxt_hrdata = {24'd0,er[7:0]};
                            //4'd7: nxt_hrdata = {16'd0,er[15:8],8'd0};
                            //4'd8: nxt_hrdata = {25'd0,bo};
                            //4'd12: nxt_hrdata = {28'd0,tx_pac};
                            //4'd13: nxt_hrdata = {31'd0,flush_ctrl};
                        endcase
                    end
                    2'b01:
                    begin
                        case (haddr)
                            4'd0:
                            begin
                                //nxt_hrdata = {16'd0,mem[read_select+1],mem[read_select]};
                                nxt_read_rx = 3'd2;
                            end
                            4'd1:
                            begin
                                //nxt_hrdata = {16'd0,mem[read_select+1],mem[read_select]};
                                nxt_read_rx = 3'd2;
                            end
                            4'd2:
                            begin
                                //nxt_hrdata = {mem[read_select+1],mem[read_select],16'd0};
                                nxt_read_rx = 3'd2;
                            end
                            4'd3:
                            begin
                                //nxt_hrdata = {mem[read_select+1],mem[read_select],16'd0};
                                nxt_read_rx = 3'd2;
                            end
                            //4'd4: nxt_hrdata = stat;
                            //4'd5: nxt_hrdata = stat;
                            //4'd6: nxt_hrdata = er;
                            //4'd7: nxt_hrdata = er;
                        endcase
                    end
                    2'b10:
                    begin
                        case (haddr)
                            4'd0:
                            begin
                                //nxt_hrdata = {mem[read_select+3],mem[read_select+2],mem[read_select+1],mem[read_select]};
                                nxt_read_rx = 3'd4;
                            end
                            4'd1:
                            begin
                                //nxt_hrdata = {mem[read_select+3],mem[read_select+2],mem[read_select+1],mem[read_select]};
                                nxt_read_rx = 3'd4;
                            end
                            4'd2:
                            begin
                                //nxt_hrdata = {mem[read_select+3],mem[read_select+2],mem[read_select+1],mem[read_select]};
                                nxt_read_rx = 3'd4;
                            end
                            4'd3:
                            begin
                                //nxt_hrdata = {mem[read_select+3],mem[read_select+2],mem[read_select+1],mem[read_select]};
                                nxt_read_rx = 3'd4;
                            end
                        endcase
                    end
                endcase
            //end
        end
    end

    logic [2:0] nxt_write_tx,write_tx;
    logic clear_tx;

    //STATE MACHINE TO READ DATA
    typedef enum bit [2:0] {IDLE,ACTIVE,RD1,RD2,RD3,RD4} stateType;
    typedef enum bit [2:0] {IDLEW,ACTIVED,W1,W2,W3,W4} statedataType;
    stateType read_state,nxt_read_state;
    statedataType write_data_state,nxt_write_data_state;

    always_ff @(posedge clk,negedge n_rst) begin : REG_READ_STATE
        if (!n_rst)
        begin
            read_state <= IDLE;
            write_data_state <= IDLEW;
            read_rx <= '0;
        end
        else
        begin
            read_state <= nxt_read_state;
            write_data_state <= nxt_write_data_state;
            read_rx <= nxt_read_rx;
        end
    end

    always_comb begin : NXT_READ_STATE
        nxt_read_state = read_state;
        clear_rx = 1'b0;
        case (read_state)
            IDLE:
            begin
                if (read_rx != 0)
                    nxt_read_state = RD1;
                else
                    nxt_read_state = IDLE;
            end
            RD1:
            begin
                if (read_rx == 3'd1)
                begin
                    nxt_read_state = IDLE;
                    clear_rx = 1'b1;
                end
                else
                    nxt_read_state = RD2;
            end
            RD2:
            begin
                if (read_rx == 3'd2)
                begin
                    nxt_read_state = IDLE;
                    clear_rx = 1'b1;
                end
                else
                    nxt_read_state = RD3;
            end
            RD3:
            begin
                if (read_rx == 3'd0)
                    nxt_read_state = IDLE;
                else
                    nxt_read_state = RD4;
            end
            RD4:
            begin
                nxt_read_state = IDLE;
                clear_rx = 1'b1;
            end
        endcase
    end

    always_comb begin : NXT_WRITE_DATA
        nxt_write_data_state = write_data_state;
        clear_tx = 1'b0;
        case (write_data_state)
            IDLEW: 
            begin
                if (write_tx != 3'd0)
                    nxt_write_data_state = ACTIVED;
                else
                    nxt_write_data_state = IDLEW;
            end
            ACTIVED:
            begin
                nxt_write_data_state = W1;
            end
            W1:
            begin
                if (write_tx == 3'd1)
                begin
                    nxt_write_data_state = IDLEW;
                    clear_tx = 1'b1;
                end
                else
                    nxt_write_data_state = W2;
            end
            W2:
            begin
                if (write_tx == 3'd2)
                begin
                    nxt_write_data_state = IDLEW;
                    clear_tx = 1'b1;
                end
                else
                    nxt_write_data_state = W3;
            end
            W3:
            begin
                if (write_tx == 3'd0)
                    nxt_write_data_state = IDLEW;
                else
                begin
                    nxt_write_data_state = W4;
                    //clear_tx = 1'b1;
                end
            end
            W4:
            begin
                nxt_write_data_state = IDLEW;
                clear_tx = 1'b1;
            end
        endcase
    end

    //logic [2:0] nxt_write_tx,write_tx;
    //logic clear_tx;
    
    //AHB WRITING DATA
    always_ff @(posedge clk,negedge n_rst) begin : REG_TX_FLUSH
        if (!n_rst)
        begin
            tx_pac <= '0;
            flush_ctrl <= '0;
            write_tx <= '0;
        end
        else
        begin
            tx_pac <= nxt_tx_pac;
            flush_ctrl <= nxt_flush_ctrl;
            write_tx <= nxt_write_tx;
        end
    end


    always_comb begin : WRITE_TO_DATA_B
        hready = 1'b1;
        get_rx_data = 1'b0;
        store_tx_data = 1'b0;
        tx_data = '0;
        nxt_tx_pac = tx_pac;
        nxt_flush_ctrl = flush_ctrl;
        nxt_mem = mem;
        nxt_hrdata = hrdata;
        hresp = '0;

        if (hsel)
        begin
            if ((hwrite == 1) && (haddr<9) && (haddr>3) || (hsize == 3) || (haddr>13) || (haddr==9) || (haddr==10) || (haddr==11)) //HRESP ERROR
            begin
                hresp = 1'b1;
                hready = 1'b0;
            end
        end
        if (hsel) begin
            if ((hwrite_f == 1) && (haddr_f<9) && (haddr_f>3) || (hsize_f == 3) || (haddr_f>13) || (haddr_f==9) || (haddr_f==10) || (haddr_f==11))
            begin
                hresp = 1'b1;
                hready = 1'b1;
            end
        end

        if ((hsel == 1) && (hwrite == 0) && (htrans == TRANS_NON))
        begin
            if (hazard == 1)
            begin
                nxt_hrdata = hwdata;
            end
            else
            begin
                case (hsize)
                    2'b00:
                    begin
                        case (haddr)
                            4'd4: nxt_hrdata = {24'd0,stat[7:0]};
                            4'd5: nxt_hrdata = {16'd0,stat[15:8],8'd0};
                            4'd6: nxt_hrdata = {24'd0,er[7:0]};
                            4'd7: nxt_hrdata = {16'd0,er[15:8],8'd0};
                            4'd8: nxt_hrdata = {25'd0,bo};
                            4'd12: nxt_hrdata = {28'd0,tx_pac};
                            4'd13: nxt_hrdata = {31'd0,flush_ctrl};
                        endcase
                    end
                    2'b01:
                    begin
                        case (haddr)
                            4'd4: nxt_hrdata = stat;
                            4'd5: nxt_hrdata = stat;
                            4'd6: nxt_hrdata = er;
                            4'd7: nxt_hrdata = er;
                        endcase
                    end
                endcase
            end
        end


        case (read_state)
            IDLE:
            begin
                if (nxt_read_state == RD1)
                    hready = 1'b0;
                //else
                    //hready = 1'b1;
            end
            RD1:
            begin
                get_rx_data = 1'b1;
                nxt_hrdata[7:0] = rx_data;
                hready = 1'b0;
            end
            RD2:
            begin
                get_rx_data = 1'b1;
                nxt_hrdata[15:8] = rx_data;
                hready = 1'b0;
            end
            RD3:
            begin
                get_rx_data = 1'b1;
                nxt_hrdata[23:16] = rx_data;
                hready = 1'b0;
            end
            RD4:
            begin
                get_rx_data = 1'b1;
                nxt_hrdata[31:24] = rx_data;
                hready = 1'b0;
            end
        endcase

        case (write_data_state)
            IDLEW:
            begin
                if (nxt_write_data_state == ACTIVED)
                    hready = 1'b0;
            end
            ACTIVED:
            begin
                if (nxt_write_data_state == W1)
                    hready = 1'b0;
            end
            W1:
            begin
                store_tx_data = 1'b1;
                tx_data = mem[write_select];
                hready = 1'b0;
            end
            W2:
            begin
                store_tx_data = 1'b1;
                tx_data = mem[write_select+1];
                hready = 1'b0;
            end
            W3:
            begin
                store_tx_data = 1'b1;
                tx_data = mem[write_select+2];
                hready = 1'b0;
            end
            W4:
            begin
                store_tx_data = 1'b1;
                tx_data = mem[write_select+3];
                hready = 1'b0;
            end
        endcase

        //nxt_tx_pac = tx_pac;
        //nxt_flush_ctrl = flush_ctrl;

        if (clear_tx == 1'b1)
            nxt_write_tx = '0;
        else
        begin
            nxt_write_tx = write_tx;
        end

        if ((hsel == 1) && (hwrite_f == 1) && (htrans_f == TRANS_NON))
        begin // Write Command
            case (hsize_f)
                2'd0:
                begin // 1 byte write
                    case (haddr_f)
                        4'd0 :
                        begin
                            nxt_mem[write_select] = hwdata[7:0];
                            //nxt_write_tx = 3'd1;
                        end
                        4'd1 :
                        begin
                            nxt_mem[write_select] = hwdata[15:8];
                            //nxt_write_tx = 3'd1;
                        end
                        4'd2 :
                        begin
                            nxt_mem[write_select] = hwdata[23:16];
                            //nxt_write_tx = 3'd1;
                        end
                        4'd3 :
                        begin
                            nxt_mem[write_select] = hwdata[31:24];
                            //nxt_write_tx = 3'd1;
                        end
                        4'd12: nxt_tx_pac = x;
                        4'd13: nxt_flush_ctrl = hwdata[0];
                        //default: hresp = 1'b1;
                    endcase
                end 
                2'd1:
                begin // 2 byte write
                    case (haddr_f)
                        4'd0,4'd1 :
                        begin
                            {nxt_mem[write_select+1],nxt_mem[write_select]} = hwdata[15:0];
                            //nxt_write_tx = 3'd2;
                        end
                        4'd2,4'd3 :
                        begin
                            {nxt_mem[write_select+1],nxt_mem[write_select]} = hwdata[31:16];
                            //nxt_write_tx = 3'd2;
                        end
                    endcase
                end
                2'd2:
                begin //4 byte write
                    case (haddr_f)
                        4'd0,4'd1,4'd2,4'd3:
                        begin
                            {nxt_mem[write_select+3],nxt_mem[write_select+2],nxt_mem[write_select+1],nxt_mem[write_select]} = hwdata;
                            //nxt_write_tx = 3'd4;
                        end
                    endcase
                end
            endcase
        end


        if ((hsel == 1) && (hwrite == 1) && (htrans == TRANS_NON))
        begin // Write Command
            case (hsize)
                2'd0:
                begin // 1 byte write
                    case (haddr)
                        4'd0 :
                        begin
                            nxt_write_tx = 3'd1;
                        end
                        4'd1 :
                        begin
                            nxt_write_tx = 3'd1;
                        end
                        4'd2 :
                        begin
                            nxt_write_tx = 3'd1;
                        end
                        4'd3 :
                        begin
                            nxt_write_tx = 3'd1;
                        end
                        //default: hresp = 1'b1;
                    endcase
                end 
                2'd1:
                begin // 2 byte write
                    case (haddr)
                        4'd0,4'd1 :
                        begin
                            nxt_write_tx = 3'd2;
                        end
                        4'd2,4'd3 :
                        begin
                            nxt_write_tx = 3'd2;
                        end
                    endcase
                end
                2'd2:
                begin //4 byte write
                    case (haddr)
                        4'd0,4'd1,4'd2,4'd3:
                        begin
                            nxt_write_tx = 3'd4;
                        end
                    endcase
                end
            endcase
        end

        
        //nxt_flush_ctrl = flush_ctrl;
        if (buffer_occupancy == 0)
            nxt_flush_ctrl = '0;

        if (tx_transfer_active_falling_edge == 1)
            nxt_tx_pac = '0;
    end
    
    falling_edge_detect falling_edge_detect_tx_transfer_active (
        .clk(clk),
        .n_rst(n_rst),
        .dplus_sync(tx_transfer_active),
        .d_edge(tx_transfer_active_falling_edge)
    );
    // TX_PACKET_CONTROL
    always_comb begin : TX_CONTROL_OUT
        x = '0;
        //if (tx_transfer_active == 1'b0)
            //x = '0;
        case (hwdata)
            32'd1 : x = DATA0;
            32'd2 : x = ACK;
            32'd3 : x = NAK;
            32'd4 : x = STALL;
        endcase
    end

    assign clear = flush_ctrl;
    assign tx_packet = tx_pac;

    always_comb begin : D_MODE
        d_mode = '0;
        if (rx_transfer_active == 1'b0)
            d_mode = 1'b1;
    end

endmodule