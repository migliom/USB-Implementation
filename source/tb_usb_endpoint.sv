// $Id: $
// File name:   tb_usb_endpoint.sv
// Created:     4/25/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: tb for the usb_endpoint

`timescale 1ns/10ps

module tb_usb_endpoint();
    // CONSTANTS
    localparam CLK_PERIOD = 10;
    localparam BUS_DELAY  = 800ps; // Based on FF propagation delay
    localparam DATA_PERIOD  = (8 * CLK_PERIOD);

    localparam SYNC_BYTE = 8'b10000000;
    // Sizing related constants
    localparam DATA_WIDTH      = 4;
    localparam ADDR_WIDTH      = 8;
    localparam DATA_WIDTH_BITS = DATA_WIDTH * 8;
    localparam DATA_MAX_BIT    = DATA_WIDTH_BITS - 1;
    localparam ADDR_MAX_BIT    = ADDR_WIDTH - 1;
    // AHB Register Indices;
    localparam DATA_BUFF_IND        = 0;  //size = 4
    localparam STATUS_IND           = 4;  //size = 2
    localparam ERROR_IND            = 6;  //size = 2
    localparam BUFFER_OCCUPANCY_IND = 8;  //size = 1
    localparam WRITE_STATUS_IND     = 9;  //size = 1
    localparam READ_STATUS_IND      = 10; //size = 1
    localparam BYTE_IND             = 11; //size = 1
    localparam TX_CONTROL_IND       = 12; //size = 1
    localparam FLUSH_CONTROL_IND    = 13; //size = 1

    localparam OUT   = 4'b0001;
    localparam IN    = 4'b1001;
    localparam DATA0 = 4'b0011;
    localparam DATA1 = 4'b1011;
    localparam ACK   = 4'b0010;
    localparam NAK   = 4'b1010;
    localparam STALL = 4'b1110;

    // Packet ID
    localparam PID_OUT = 8'b11100001; //0001 -> (xxxx)0001 -> (1110)0001 -> Take NRZI encoding of that -> 
    //localparam ENCODED_PID_OUT = 8'b11110101 ; //01111010
    localparam ENCODED_PID_OUT = 8'b11110101;

    localparam PID_IN = 8'b01101001; 
    //localparam ENCODED_PID_IN = 8'b01110010;
    localparam ENCODED_PID_IN = 8'b10100100;

    localparam PID_DATA0 = 8'b11000011; 
    //localparam ENCODED_PID_DATA0 = 8'b00010100;
    localparam ENCODED_PID_DATA0 = 8'b10101000;

    localparam PID_DATA1 = 8'b01001011; 
    localparam ENCODED_PID_DATA1 = 8'b01101100;

    localparam PID_ACK = 8'b11010010; 
    localparam ENCODED_PID_ACK = 8'b00011011;
    
    localparam PID_NACK = 8'b01011010;
    localparam ENCODED_PID_NACK = 8'b01100011;

    localparam USB_ENDPOINT = 16'b1111100001010101;
    localparam DEFAULT_DATA = DATA0;
    // AHB-Lite-Slave reset value constants
    localparam RESET_VALUE  = '0;

    logic [7:0] expected_rx_data_c;

    typedef struct
    {
    logic [7:0] tb_sync_in = 8'b10000000;

    logic [5:0][7:0] tb_pid_in = {PID_OUT, PID_IN, PID_DATA0, PID_DATA1,PID_ACK, ENCODED_PID_NACK};

    logic [5:0][7:0] tb_pid_in_encoded = {ENCODED_PID_OUT, 
            ENCODED_PID_IN, ENCODED_PID_DATA0, ENCODED_PID_DATA1,
            ENCODED_PID_ACK, ENCODED_PID_NACK};

    logic [63:0][7:0] tb_test_data_in;
    } testVectorRX;

    //*****************************************************************************
    // General System signals
    //*****************************************************************************
    logic tb_clk;
    logic tb_n_rst;

    //*****************************************************************************
    // Declare TB Signals (DUT Signals)
    //*****************************************************************************
    logic                  tb_hsel;
    logic [1:0]            tb_htrans;
    logic [3:0] tb_haddr;
    logic [1:0]            tb_hsize;
    logic                  tb_hwrite;
    logic [DATA_MAX_BIT:0] tb_hwdata;
    logic [DATA_MAX_BIT:0] tb_hrdata;
    logic                  tb_hresp;
    logic                  tb_dplus_in;
    logic                  tb_dminus_in;
    logic                  tb_dmode;
    logic                  tb_dplus_out;
    logic                  tb_dminus_out;

    //*****************************************************************************
    // Expected Signals
    //*****************************************************************************
    logic tb_expected_dplus_out;
    logic tb_expected_dminus_out;
    //*****************************************************************************
    // Calculation signals
    //*****************************************************************************
    logic dplus_out;
    logic dminus_out;

    //*****************************************************************************
    // Declare TB Signals (Bus Model Controls)
    //*****************************************************************************
    // Testing setup signals
    logic                      tb_enqueue_transaction;
    logic                      tb_transaction_write;
    logic                      tb_transaction_fake;
    logic [ADDR_MAX_BIT:0]     tb_transaction_addr;
    bit [((DATA_WIDTH*8) - 1):0] tb_transaction_data [];
    logic                      tb_transaction_error;
    logic [2:0]                tb_transaction_size;
    // Testing control signal(s)
    logic    tb_enable_transactions;
    integer  tb_current_addr_transaction_num;
    integer  tb_current_addr_beat_num;
    logic    tb_current_addr_transaction_error;
    integer  tb_current_data_transaction_num;
    integer  tb_current_data_beat_num;
    logic    tb_current_data_transaction_error;
    logic    tb_model_reset;
    string   tb_test_case;
    integer  tb_test_case_num;
    bit   [DATA_MAX_BIT:0] tb_test_data [];
    string                 tb_check_tag;
    logic                  tb_mismatch;
    logic                  tb_check;
    //*****************************************************************************
    // Clock Generation Block
    //*****************************************************************************
    // Clock generation block
    always begin
        // Start with clock low to avoid false rising edge events at t=0
        tb_clk = 1'b0;
        // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
        #(CLK_PERIOD/2.0);
    end
    //*****************************************************************************
    // Test Vector
    //*****************************************************************************
    typedef struct {
        logic [7:0] data[63:0];
        integer amount;
        logic error;
        logic ACK;
        logic NAK;
        logic DATA;
        logic [1:0] transaction_size;
        string test_name;
    } testVector;
    testVector tb_test_vectors[];

    //*****************************************************************************
    // Bus Model Instance
    //*****************************************************************************
    /*
    ahb_lite_bus #(.DATA_WIDTH(DATA_WIDTH)) BFM (.clk(tb_clk),
                  // Testing setup signals
                  .enqueue_transaction(tb_enqueue_transaction),
                  .transaction_write(tb_transaction_write),
                  .transaction_fake(tb_transaction_fake),
                  .transaction_addr(tb_transaction_addr),
                  .transaction_data(tb_transaction_data),
                  .transaction_error(tb_transaction_error),
                  .transaction_size(tb_transaction_size),
                  // Testing controls
                  .model_reset(tb_model_reset),
                  .enable_transactions(tb_enable_transactions),
                  .current_transaction_num(tb_current_transaction_num),
                  .current_transaction_error(tb_current_transaction_error),
                  // AHB-Lite-Slave Side
                  .hsel(tb_hsel),
                  .htrans(tb_htrans),
                  .haddr(tb_haddr),
                  .hsize(tb_hsize),
                  .hwrite(tb_hwrite),
                  .hwdata(tb_hwdata),
                  .hrdata(tb_hrdata),
                  .hresp(tb_hresp));
    */

    ahb_lite_bus_cdl 
              #(  .DATA_WIDTH(4),
                  .ADDR_WIDTH(8))
              BFM(.clk(tb_clk),
                  // Testing setup signals
                  .enqueue_transaction(tb_enqueue_transaction),
                  .transaction_write(tb_transaction_write),
                  .transaction_fake(tb_transaction_fake),
                  .transaction_addr(tb_transaction_addr),
                  .transaction_size(tb_transaction_size),
                  .transaction_data(tb_transaction_data),
                  .transaction_burst(tb_transaction_burst),
                  .transaction_error(tb_transaction_error),
                  // Testing controls
                  .model_reset(tb_model_reset),
                  .enable_transactions(tb_enable_transactions),
                  .current_addr_transaction_num(tb_current_addr_transaction_num),
                  .current_addr_beat_num(tb_current_addr_beat_num),
                  .current_addr_transaction_error(tb_current_addr_transaction_error),
                  .current_data_transaction_num(tb_current_data_transaction_num),
                  .current_data_beat_num(tb_current_data_beat_num),
                  .current_data_transaction_error(tb_current_data_transaction_error),
                  // AHB-Lite-Slave Side
                  .hsel(tb_hsel),
                  .haddr(tb_haddr),
                  .hsize(tb_hsize),
                  .htrans(tb_htrans),
                  .hburst(tb_hburst),
                  .hwrite(tb_hwrite),
                  .hwdata(tb_hwdata),
                  .hrdata(tb_hrdata),
                  .hresp(tb_hresp),
                  .hready(tb_hready));

    // ************************************************************************
    // DUT
    // ************************************************************************
    usb_endpoint DUT
    (
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .hsel(tb_hsel),
        .haddr(tb_haddr),
        .htrans(tb_htrans),
        .hsize(tb_hsize),
        .hwrite(tb_hwrite),
        .hwdata(tb_hwdata),
        .dplus_in(tb_dplus_in),
        .dminus_in(tb_dminus_in),
        .hrdata(tb_hrdata),
        .hresp(tb_hresp),
        .hready(tb_hready),
        .d_mode(tb_dmode),
        .dplus_out(tb_dplus_out),
        .dminus_out(tb_dminus_out)
    );

    //*****************************************************************************
    // Bus Model Usage Related TB Tasks
    //*****************************************************************************
    // Task to pulse the reset for the bus model
    task reset_model;
    begin
    tb_model_reset = 1'b1;
    #(0.1);
    tb_model_reset = 1'b0;
    end
    endtask

    task encode_byte_and_send;
    input logic [7:0] data;
    integer i;
    begin
        //@(negedge tb_clk);
        for (i = 0; i < 8; i++) begin
        if (data[i] == 1'b0) begin
            tb_dplus_in = ~tb_dplus_in;
            tb_dminus_in = ~tb_dminus_in;
        end
        #(DATA_PERIOD);
        end
    end
    endtask

    task send_eop;
    begin
    // Send EOP Sequence
    tb_dplus_in = 1'b0;
    tb_dminus_in = 1'b0;
    #(DATA_PERIOD);
    #(DATA_PERIOD);
    
    tb_dplus_in = 1'b1;
    tb_dminus_in = 1'b0;
    #(DATA_PERIOD);
    //how to in keep it in idle instead of detecting an edge?
    end
    endtask

    task premature_eop;
    logic [7:0] data;
    integer i;
    begin
        //@(negedge tb_clk);
        data = 8'hc4;
        for (i = 0; i < 5; i++) begin
        if (data[i] == 1'b0) begin
            tb_dplus_in = ~tb_dplus_in;
            tb_dminus_in = ~tb_dminus_in;
        end
            #(DATA_PERIOD);
        end
        send_eop();
    end
    endtask

    // Task to enqueue a new transaction
    task enqueue_transaction;
    input logic for_dut;
    input logic write_mode;
    input logic [ADDR_MAX_BIT:0] address;
    input bit [DATA_MAX_BIT:0] data [];
    input logic expected_error;
    input logic [1:0] size;
    begin
    // Make sure enqueue flag is low (will need a 0->1 pulse later)
    tb_enqueue_transaction = 1'b0;
    #0.1ns;

    // Setup info about transaction
    tb_transaction_fake  = ~for_dut;
    tb_transaction_write = write_mode;
    tb_transaction_addr  = address;
    tb_transaction_data  = data;
    tb_transaction_error = expected_error;
    tb_transaction_size  = {1'b0,size};

    // Pulse the enqueue flag
    tb_enqueue_transaction = 1'b1;
    #0.1ns;
    tb_enqueue_transaction = 1'b0;
    end
    endtask

    // Task to wait for multiple transactions to happen
    task execute_transactions;
    input integer num_transactions;
    integer wait_var;
    begin
    // Activate the bus model
    tb_enable_transactions = 1'b1;
    @(posedge tb_clk);

    // Process the transactions (all but last one overlap 1 out of 2 cycles
    for(wait_var = 0; wait_var < num_transactions; wait_var++) begin
        //tb_current_transaction_num++;
        @(posedge tb_clk);

    end

    // Run out the last one (currently in data phase)
    //tb_current_transaction_num++;
    @(posedge tb_clk);

    // Turn off the bus model
    @(negedge tb_clk);
    tb_enable_transactions = 1'b0;
    end
    endtask

    // ************************************************************************
    // ************************************************************************
    // TASKS
    // ************************************************************************
    // ************************************************************************
    task reset_dut;
    begin
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(negedge tb_clk);
        tb_n_rst = 1'b1;
        @(negedge tb_clk);
        @(negedge tb_clk);
    end
    endtask
    task reset_dut_inputs;
    begin
        tb_dplus_in = 1;
        tb_dminus_in = 0;
    end
    endtask
    task wait_for;
        input integer i;
        integer j;
    begin
        for (j = 0; j < i; j++) begin
            #(CLK_PERIOD);
        end
    end
    endtask
    // ************************************************************************
    // AHB-Slave register tasks
    // ************************************************************************
    // Reads
    task read_tx_control;
        input bit [31:0] data [];
    begin
        enqueue_transaction(1, 0, TX_CONTROL_IND, data, 0, 0);
        execute_transactions(1);
    end
    endtask

    task read_buffer_occupancy;
        input bit [31:0] data [];
    begin
        enqueue_transaction(1,0, BUFFER_OCCUPANCY_IND, data, 0, 0);
        execute_transactions(1);
    end
    endtask

    task read_status;
        input bit [31:0] data [];
    begin
        enqueue_transaction(1,0, STATUS_IND, data, 0, 1);
        execute_transactions(1);
    end
    endtask

    task read_error;
        input bit [31:0] data [];
    begin
        enqueue_transaction(1,0,ERROR_IND, data, 0, 1);
        execute_transactions(1);
    end
    endtask

    task read_flush;
        input bit [31:0] data [];
    begin
        enqueue_transaction(1,0,FLUSH_CONTROL_IND, data, 0, 0);
        execute_transactions(1);
    end
    endtask

    // Writes
    task write_tx_control;
        input bit [31:0] data [];
    begin
        enqueue_transaction(1, 1, TX_CONTROL_IND, data, 0, 0 );
        execute_transactions(1);
    end
    endtask

    task write_flush_control;
        input bit [31:0] data [];
    begin
        enqueue_transaction(1, 1, FLUSH_CONTROL_IND, data, 0, 0 );
        execute_transactions(1);
    end
    endtask

    task write_bytes;
        input integer vector_number;
        integer i;
        bit [31:0] data [];
        integer num_bytes;
        integer loop_amount;
        integer execute_amount;
    begin 
        if (tb_test_vectors[vector_number].transaction_size == 2) begin
            num_bytes = 4;
            execute_amount = 7;
        end
        else if (tb_test_vectors[vector_number].transaction_size == 1) begin
            num_bytes = 2;
            execute_amount = 5;
        end
        else begin
            num_bytes = 1;
            execute_amount = 3;
        end
        loop_amount = tb_test_vectors[vector_number].amount;
        //$info("loop_amount: %d", loop_amount);
        for (i = 0; i < loop_amount; i = i + num_bytes) begin
            case (num_bytes)
                4: begin
                    //NOTE: this should be one 32-bit wide signal
                    //NOTE: which order are the bytes written? lsb byte first?
                    data = '{{tb_test_vectors[vector_number].data[i+3], tb_test_vectors[vector_number].data[i+2], tb_test_vectors[vector_number].data[i+1], tb_test_vectors[vector_number].data[i]}};
                end 
                2: begin
                    data = '{{16'b0, tb_test_vectors[vector_number].data[i+1], tb_test_vectors[vector_number].data[i]}};
                end
                1: begin
                    data = '{{24'b0, tb_test_vectors[vector_number].data[i]}};
                end
            endcase
            enqueue_transaction(1, 1, DATA_BUFF_IND, data, 0, tb_test_vectors[vector_number].transaction_size);
            execute_transactions(execute_amount);
            @(negedge tb_clk);
            //$info("i: %d", i);
        end
        //$info("Written Bytes");
    end
    endtask
    // ************************************************************************
    // HOST-TO-ENDPOINT TASKS
    // ************************************************************************
    task populate_test_vector;
        input integer vector_number;
        input integer amount;
        input logic error;
        input logic ACK;
        input logic NAK;
        input logic DATA;
        input logic [1:0] transaction_size;
        input string test_name;
        logic [7:0] data_byte;
        integer i;
    begin
        tb_test_vectors[vector_number].amount = amount;
        tb_test_vectors[vector_number].error = error;
        tb_test_vectors[vector_number].ACK = ACK;
        tb_test_vectors[vector_number].NAK = NAK;
        tb_test_vectors[vector_number].DATA = DATA;
        tb_test_vectors[vector_number].transaction_size = transaction_size;
        tb_test_vectors[vector_number].test_name = test_name;
        if (amount != 0) begin
            data_byte = 1;
            for (i = 0; i < amount; i++ ) begin
                tb_test_vectors[vector_number].data[i] = data_byte;
                data_byte = data_byte + 1;            
            end
        end
        assert(transaction_size == 2 || transaction_size == 1 || transaction_size == 0)
        else $error("Wrong transaction size for test vector!");
        assert (ACK | NAK | DATA == 1)
        else $error("No type selected for test vector!");
        assert (int'(ACK)+int'(NAK)+int'(DATA) < 2)
        else $error("More than one type selected for test vector!");
        //$info("Populated");
    end
    endtask

    task set_tx_expected;
        input logic Dp, Dm;
    begin
        tb_expected_dplus_out = Dp;
        tb_expected_dminus_out = Dm;
    end
    endtask

    task next_d;
        input integer i;
        input logic [7:0] data;
        input logic prev_Dp;
        input logic prev_Dm;
    begin
        if (data[i] == 0) begin
            dplus_out = ~prev_Dp;
            dminus_out = ~prev_Dm;
        end
        else begin
            dplus_out = prev_Dp;
            dminus_out = prev_Dm;
        end
    end
    endtask

    task check_tx_outputs;
        input string tag;
    begin
        assert (tb_dplus_out == tb_expected_dplus_out)
        else begin
            $error("Incorrect Dplus_out for test case: %d: %s: tagged: %s", tb_test_case_num, tb_test_case, tag);
        end
        assert (tb_dminus_out == tb_expected_dminus_out)
        else begin
            $error("Incorrect Dminus_out: %d: %s: tagged: %s", tb_test_case_num, tb_test_case, tag);
        end
    end
    endtask

    task check_byte;
        input logic [7:0] byte_to_check;
        integer i;
    begin
        for (i = 0; i < 8; i++) begin
            next_d(i, byte_to_check, dplus_out, dminus_out);
            set_tx_expected(.Dp(dplus_out), .Dm(dminus_out));
            wait_for(4); //Wait for 4 clock cycles
            check_tx_outputs(string'(i+48));
            wait_for(4); //Wait for 4 clock cycles
        end
    end
    endtask

    task check_eop;
    begin
        //EOP1
        set_tx_expected(.Dp(0), .Dm(0));
        wait_for(4); //Wait for 4 clock cycles
        check_tx_outputs("EOP1");
        wait_for(4); //Wait for 4 clock cycles
        //EOP2
        set_tx_expected(.Dp(0), .Dm(0));
        wait_for(4); //Wait for 4 clock cycles
        check_tx_outputs("EOP2");
        wait_for(4); //Wait for 4 clock cycles
        //Mandatory IDLE
        set_tx_expected(.Dp(1), .Dm(0));
        wait_for(4); //Wait for 4 clock cycles
        check_tx_outputs("Mandatory IDLE");
        wait_for(4); //Wait for 4 clock cycles
        //Should now be idle
        set_tx_expected(.Dp(1), .Dm(0));
        wait_for(1);
        check_tx_outputs("Complete IDLE");
        @(posedge tb_clk);
        @(negedge tb_clk);
        check_tx_outputs("Complete IDLE Still");
    end
    endtask

    task check_tx_thread;
        input testVector tv;
        integer i;
    begin
        check_byte(SYNC_BYTE);
        if (tv.DATA == 1) begin
            if (tv.error != 1) begin
                check_byte({~DEFAULT_DATA, DEFAULT_DATA});
                for (i = 0; i < tv.amount; i++) begin
                    check_byte(tv.data[i]);
                end
            end
            else begin
                check_byte({~NAK, NAK});
            end
        end
        else if (tv.ACK == 1) 
            check_byte({~ACK, ACK});
        else if (tv.NAK == 1)
            check_byte({~NAK, NAK});

        check_eop();
    end
    endtask

    task check_host_to_endpoint;
        input integer vector_number;
        testVector tv;
    begin
        dplus_out = 1;
        dminus_out = 0;
        tv = tb_test_vectors[vector_number];
        tb_test_case = tv.test_name;
        if (tv.DATA == 1) begin
            if (tv.error != 1) begin
                write_bytes(vector_number);
            end
        end
        wait_for(4);
        if (tv.ACK == 1)
            write_tx_control('{32'd2});
        else if (tv.NAK == 1)
            write_tx_control('{32'd3});
        else if (tv.DATA == 1)
            write_tx_control('{32'd1});
        
        //$info("write tx control");
        if (tv.error != 1) begin
            @(negedge tb_dplus_out);
            //$info("dplus_out no longer idle");
            #(0.1);
            fork
                begin
                    check_tx_thread(tv);
                end            
                begin
                    // NOTE: Check if this is the correct status
                    read_status('{32'h00000200});
                    if (tv.DATA == 1)
                        read_tx_control('{DEFAULT_DATA});
                    else if (tv.ACK == 1)
                        read_tx_control('{ACK});
                    else if (tv.NAK == 1)
                        read_tx_control('{NAK});
                end
            join
        end
        wait_for(4);
        read_buffer_occupancy('{32'd0});
        //$info("Read status should be 0");
        read_status('{32'd0});
        read_tx_control('{32'd0});
        if (tv.error == 1) begin
            read_error('{32'h00000100});
        end
        else begin
            read_error('{32'd0});
        end
    end
    endtask

    task check_endpoint_to_host;
        input testVectorRX test_v;
        input logic [63:0][7:0] test_rx_data;
        input logic [7:0] error_payload;
        input integer payload_size;
        input string test_case_name;
        input bit [1:0] error_case;
        integer i;
        logic [7:0] expected_rx_data;
    begin
        $info(test_case_name);
        reset_dut_inputs();
        reset_dut();
        read_buffer_occupancy('{32'd0});

        @(negedge tb_clk);
        encode_byte_and_send(test_v.tb_sync_in);
        encode_byte_and_send(test_v.tb_pid_in[3]); //DATA0

        for(i = 0; i < payload_size; i++) begin
            encode_byte_and_send(test_rx_data[i]);

        end

        if(error_case[1]) // too much data 
        begin
            encode_byte_and_send(error_payload);
            wait_for(4);
            read_error('{32'd1});
        end

        if(error_case[0]) begin //premature eop case
            premature_eop();
            wait_for(4);
            read_error('{32'd1});
        end

        else send_eop();

        wait_for(2);
        @(negedge tb_clk); //synchronize to negedge

        for(i = 0; i < payload_size; i++) begin
            expected_rx_data = test_rx_data[i];
            expected_rx_data_c = expected_rx_data;
            if (i < 64) begin
                enqueue_transaction(1, 0, DATA_BUFF_IND, '{expected_rx_data}, 0, 0);
                $info("Ignore bus model Incorrect hrdata");
                execute_transactions(3); //execute for 3 clock cycles
                assert(expected_rx_data == tb_hrdata) begin
                    //$info("MANUAL: Correct hrdata for read buffer endpoint to host");
                end
                else $error("MANUAL: Incorrect hrdata for read buffer endpoint to host");
            end
            @(negedge tb_clk);
        end

    end
    endtask

    task endpoint_to_host_pid;
        input testVectorRX test_v;
        input logic [7:0] en_to_host_pid;
        input logic [1:0][7:0] test_rx_data;
        input string test_case_name;
        integer i;
        logic [7:0] expected_rx_data;
    begin
        $info(test_case_name);
        reset_dut_inputs();
        reset_dut();
        read_buffer_occupancy('{32'd0});

        @(negedge tb_clk);
        fork
            begin 
                encode_byte_and_send(test_v.tb_sync_in); 
                encode_byte_and_send(en_to_host_pid);
                if(en_to_host_pid == PID_OUT || en_to_host_pid == PID_IN) begin
                    for(i = 0; i < 2; i++) begin
                        encode_byte_and_send(test_rx_data[i]);
                    end
                end
                send_eop();
            end
            begin
                wait_for(64);
                wait_for(64);
                case(en_to_host_pid)
                    PID_IN: read_status('{32'h102});
                    PID_OUT: read_status('{32'h104});
                    PID_ACK: read_status('{32'h108});
                    PID_NACK: read_status('{32'h110});
                    
                endcase
            end
        join
    end
    endtask
        
        //
    // ************************************************************************
    // MAIN BLOCK
    // ************************************************************************
    integer i;
    integer max_test_vector;
    initial begin
        static logic [63:0][7:0] test_rx_data = {{8'hc4}, {8'h87}, {8'hff}, {8'hed}, {8'ha2}, {8'hcf}, {8'h78}, {8'h9c},
                              {8'hde}, {8'hff}, {8'ha1}, {8'h01}, {8'h00}, {8'h55}, {8'h5d}, {8'hdd},
                              {8'hee}, {8'h54}, {8'h76}, {8'h8d}, {8'h52}, {8'hff}, {8'hdd}, {8'hae},
                              {8'ha6}, {8'hb4}, {8'h77}, {8'h63}, {8'hd3}, {8'h99}, {8'haa}, {8'h43},
                              {8'h64}, {8'h96}, {8'h69}, {8'h77}, {8'h45}, {8'hf4}, {8'hb5}, {8'hbb},
                              {8'hc6}, {8'h88}, {8'he4}, {8'hee}, {8'hdd}, {8'h80}, {8'h07}, {8'h10},
                              {8'h80}, {8'h73}, {8'hda}, {8'hbe}, {8'hcb}, {8'hff}, {8'h00}, {8'h65},
                              {8'h98}, {8'hfe}, {8'hef}, {8'hcc}, {8'hab}, {8'hbc}, {8'h33}, {8'hf2}};
        testVectorRX test_v;
        // ************************************************************************
        // Initialization
        // ************************************************************************
        tb_test_case = "Initialization";
        tb_test_case_num = -1;
        tb_test_data = new[1];
        tb_check_tag = "N/A";
        tb_mismatch = 1'b0;
        tb_check = 1'b0;

        tb_n_rst          = 1'b1;

        max_test_vector = 7;
        tb_test_vectors = new[max_test_vector];

        // Initialize all of the DUT control inputs
        reset_dut_inputs();
        expected_rx_data_c = '0;

        // Initialize all of the bus model control inputs
        tb_model_reset          = 1'b0;
        tb_enable_transactions  = 1'b0;
        tb_enqueue_transaction  = 1'b0;
        tb_transaction_write    = 1'b0;
        tb_transaction_fake     = 1'b0;
        tb_transaction_addr     = '0;
        tb_transaction_data     = new[1];
        tb_transaction_error    = 1'b0;
        tb_transaction_size     = 3'd0;

        // Wait some time before starting first test case
        #(0.1);

        // Clear the bus model
        reset_model();


        // ************************************************************************
        // Power-on-Reset Test Case
        // ************************************************************************
        tb_test_case     = "Power-on-Reset";
        tb_test_case_num = tb_test_case_num + 1;

        reset_dut();
        tb_expected_dplus_out = 1;
        tb_expected_dminus_out = 0;
        check_tx_outputs("After reset");
        $info("----------------BEGIN of host to endpoint");
        // ************************************************************************
        // Host to endpoint
        // ************************************************************************
        // Data: 1 bytes, 1 byte, No Error
        populate_test_vector(.vector_number(0), .amount(1), .error(0), .ACK(0), .NAK(0), .DATA(1), .transaction_size(0), .test_name("Data: 1 bytes, 1 byte, No Error"));
        // Data: 24 bytes, 2 byte, No Error
        populate_test_vector(.vector_number(1), .amount(24), .error(0), .ACK(0), .NAK(0), .DATA(1), .transaction_size(1), .test_name("Data: 24 bytes, 2 byte, No Error"));
        // Data: 48 bytes, 4 byte, No Error
        populate_test_vector(.vector_number(2), .amount(48), .error(0), .ACK(0), .NAK(0), .DATA(1), .transaction_size(2), .test_name("Data: 48 bytes, 4 byte, No Error"));
        // Data: 64 bytes, 4 byte, No Error
        populate_test_vector(.vector_number(3), .amount(64), .error(0), .ACK(0), .NAK(0), .DATA(1), .transaction_size(2), .test_name("Data: 64 bytes, 4 byte, No Error"));
        // ACK
        populate_test_vector(.vector_number(4), .amount(0), .error(0), .ACK(1), .NAK(0), .DATA(0), .transaction_size(0), .test_name("ACK"));
        // NAK
        populate_test_vector(.vector_number(5), .amount(0), .error(0), .ACK(0), .NAK(1), .DATA(0), .transaction_size(0), .test_name("NAK"));
        // Data: Error
        populate_test_vector(.vector_number(6), .amount(0), .error(1), .ACK(0), .NAK(0), .DATA(1), .transaction_size(0), .test_name("Data: Error"));
        for (i = 0; i < max_test_vector; i++) begin
            tb_test_case_num++;
            reset_dut_inputs();
            reset_dut();
            check_host_to_endpoint(i);
        end
        //$stop;
        $info("----------------END of host to endpoint");
        // ************************************************************************
        // Endpoint to host
        // ************************************************************************
        $info("----------------BEGIN of endpoint to host");
        tb_test_case = "Standard RX write to buffer and read on AHB-Slave";
        tb_test_case_num = tb_test_case_num + 1;
        reset_dut();

        //1 byte write and read, no errors
        tb_test_case = "Standard 1 byte write to RX buffer and read on AHB-Slave buffer reg";
        check_endpoint_to_host(test_v, test_rx_data, '0, 1, "Standard 1 byte write to RX buffer and read on AHB-Slave buffer reg", 2'b00);

        //16 byte write and read, no errors
        tb_test_case_num++;
        tb_test_case = "Standard 16 byte write to RX buffer and read on AHB-Slave buffer reg";
        check_endpoint_to_host(test_v, test_rx_data, '0, 16, "Standard 16 byte write to RX buffer and read on AHB-Slave buffer reg", 2'b00);

        //64 byte write and read, no errors
        tb_test_case_num++;
        tb_test_case = "Standard 64 byte write to RX buffer and read on AHB-Slave buffer reg";
        check_endpoint_to_host(test_v, test_rx_data, '0, 64, "Standard 64 byte write to RX buffer and read on AHB-Slave buffer reg", 2'b00);
        //$stop;

        //65 byte write and read 64, too much data error on RX error reg in AHB-Slave
        tb_test_case_num++;
        tb_test_case = "65 byte write and read 64, too much data error on RX error reg in AHB-Slave";
        check_endpoint_to_host(test_v, test_rx_data, 8'hc6, 65, "65 byte write and read 64, too much data error on RX error reg in AHB-Slave", 2'b10);

        //1 byte write and then premature eop mid byte on second write, error on RX error reg in AHB-Slave
        tb_test_case_num++;
        tb_test_case = "1 byte write and then premature eop mid byte on second write, error on RX error reg in AHB-Slave";
        check_endpoint_to_host(test_v, test_rx_data, '0, 1, "1 byte write and then premature eop mid byte on second write, error on RX error reg in AHB-Slave", 2'b01);

        tb_test_case_num++;
        
        //check AHB-Lite Slave status register to ensure the validity of the PID packet to be received
        tb_test_case = "ACK test case";
        endpoint_to_host_pid(test_v, PID_ACK, {{'0},{'0}}, "ACK test case");
        tb_test_case = "NACK test case";
        endpoint_to_host_pid(test_v, PID_NACK, {{'0},{'0}}, "NACK test case");
        tb_test_case = "OUT test case";
        endpoint_to_host_pid(test_v, PID_OUT, {{'0},{'0}}, "OUT test case");
        tb_test_case = "IN test case";
        endpoint_to_host_pid(test_v, PID_IN, {{'0},{'0}}, "IN test case");
        $info("----------------END of endpoint to host");
        //$stop;

        
        // ************************************************************************
        // AHB-Slave R/W
        // ************************************************************************
        $info("----------------BEGIN of AHB-Slave R/W");
        tb_test_case     = "Standard AHB Read and Write";
        tb_test_case_num = tb_test_case_num + 1;
        reset_dut();

        tb_test_case     = "Non-Overlapping read of registers";
        read_status('{32'd0});
        read_error('{32'd0});
        read_buffer_occupancy('{32'd0});
        read_tx_control('{32'd0});
        
        tb_test_case     = "Writing to Read-only registers";
        //Giving hresp high
        enqueue_transaction(1, 1, STATUS_IND, '{32'd5}, 1, 1);
        execute_transactions(1);
        wait_for(3);

        //Giving hresp high
        enqueue_transaction(1, 1, ERROR_IND, '{32'd5}, 1, 1);
        execute_transactions(1);
        wait_for(3);

        //Giving hresp high
        enqueue_transaction(1, 1, BUFFER_OCCUPANCY_IND, '{32'd5}, 1, 1);
        execute_transactions(1);
        wait_for(3);

        tb_test_case     = "Flush Control Register Tests";
        //Writing to flush and then reading
        write_flush_control('{32'd1});
        read_flush('{32'd0});
        read_buffer_occupancy('{32'd0});

        write_bytes(2);
        write_flush_control('{32'd1});
        wait_for(3);
        read_flush('{32'd0});
        read_buffer_occupancy('{32'd0});

        //Overlapping Transfers
        tb_test_case     = "Overlapping Transfers";
        enqueue_transaction(1, 0, STATUS_IND, '{32'd0}, 0, 1);
        enqueue_transaction(1, 0, ERROR_IND, '{32'd0}, 0, 1);
        enqueue_transaction(1, 0, BUFFER_OCCUPANCY_IND, '{32'd0}, 0, 1);
        execute_transactions(3);
        wait_for(3);

        tb_test_case     = "RAW Hazard";
        enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{32'h00000004}, 1'b0, 2'd0);
        enqueue_transaction(1'b1, 1'b0, TX_CONTROL_IND, '{32'h00000004}, 1'b0, 2'd0);  
        execute_transactions(1);
        wait_for(3);
        $info("----------------END of AHB-Slave R/W");
        // ************************************************************************
        // END
        // ************************************************************************
        $info("END OF ALL TEST CASES");
        $stop;
    end

endmodule
