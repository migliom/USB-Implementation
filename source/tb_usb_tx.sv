// $Id: $
// File name:   tb_usb_tx.sv
// Created:     4/22/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: Testbench for the USB TX module

`timescale 1ns/10ps

module tb_usb_tx ();
    // CONSTANTS
    localparam CLK_PERIOD = 10;
    localparam IDLE = 4'b0000 ;
    localparam DATA0 = 4'b0011 ;
    localparam DATA1 = 4'b1011;
    localparam ACK = 4'b0010;
    localparam NAK = 4'b1010;
    localparam DEFAULT_DATA = DATA0;
    localparam SYNC_BYTE = 8'b10000000;

    // Test bench signals
    integer tb_test_case_num;
    string tb_test_case_name;

    logic Dp, Dm;

    integer tb_test_vector_num;

    // DUT Signals
    logic tb_clk;
    logic tb_n_rst;
    logic [3:0] tb_tx_packet;
    logic [6:0] tb_buffer_occupancy;
    logic [7:0] tb_tx_packet_data;
    logic tb_tx_transfer_active;
    logic tb_tx_error;
    logic tb_get_tx_packet_data;
    logic tb_Dplus_out;
    logic tb_Dminus_out;
    // FIFO signals
    logic tb_clear; 
    logic tb_flush;
    logic tb_store_tx_data;
    logic tb_store_rx_packet_data;
    logic tb_get_rx_data;
    logic [7:0] tb_tx_data;
    logic [7:0] tb_rx_packet_data;
    logic [7:0] tb_rx_data;
    
    // Expected signals
    logic tb_expected_tx_transfer_active;
    logic tb_expected_tx_error;
    logic tb_expected_get_tx_packet_data;
    logic tb_expected_Dplus_out;
    logic tb_expected_Dminus_out;


    // ************************************************************************
    // DUT
    // ************************************************************************
    usb_tx DUT
    (
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .tx_packet(tb_tx_packet),
        .buffer_occupancy(tb_buffer_occupancy),
        .tx_packet_data(tb_tx_packet_data),
        .tx_transfer_active(tb_tx_transfer_active),
        .tx_error(tb_tx_error),
        .get_tx_packet_data(tb_get_tx_packet_data),
        .Dplus_out(tb_Dplus_out),
        .Dminus_out(tb_Dminus_out)
    );
    // ************************************************************************
    // FIFO
    // ************************************************************************
    fifo_data_buffer FIFO ( .clear(tb_clear),
        .flush(tb_flush),
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .store_tx_data(tb_store_tx_data),
        .store_rx_packet_data(tb_store_rx_packet_data),
        .get_rx_data(tb_get_rx_data),
        .get_tx_packet_data(tb_get_tx_packet_data),
        .tx_data(tb_tx_data), 
        .rx_packet_data(tb_rx_packet_data),
        .rx_data(tb_rx_data), 
        .tx_packet_data(tb_tx_packet_data),
        .buffer_occupancy(tb_buffer_occupancy)
    );
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
    // ************************************************************************
    // Test Vector
    // ************************************************************************
    typedef struct {
        logic [7:0] data[63:0];
        logic [6:0] amount;
    } testVector;
    testVector tb_test_vectors[];
    // ************************************************************************
    // TASKS
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
    task reset_signals;
    begin
        tb_tx_packet = '0;
        tb_clear = 0;
        tb_flush = 0;
        tb_store_tx_data = 0;
        tb_store_rx_packet_data = 0;
        tb_get_rx_data = 0;
        tb_tx_data = '0;
        tb_rx_packet_data = '0;
    end
    endtask
    task populate_sequential;
        input integer amount;
        input integer test_case;
        logic [7:0] data_byte;
        integer i;
    begin
        data_byte = 1;
        for (i = 0; i < amount; i++ ) begin
            tb_test_vectors[test_case].data[i] = data_byte;
            data_byte = data_byte + 1;            
        end
        tb_test_vectors[test_case].amount = 7'(amount);
    end
    endtask
    task load_test_stream;
        input logic mode; // 0 is store_tx_data, 1 is store_rx_packet_data
        integer i;
    begin
        @(negedge tb_clk);
        if (mode == 0) begin
            tb_store_rx_packet_data = 0;
            tb_store_tx_data = 1;
            for (i = 0; i < tb_test_vectors[tb_test_vector_num].amount; i++) begin
                tb_tx_data = tb_test_vectors[tb_test_vector_num].data[i];
                @(posedge tb_clk);
                @(negedge tb_clk);
            end
            tb_store_tx_data = 0;
        end
        else begin
            tb_store_rx_packet_data = 1;
            tb_store_tx_data = 0;
            for (i = 0; i < tb_test_vectors[tb_test_vector_num].amount; i++) begin
                tb_rx_packet_data = tb_test_vectors[tb_test_vector_num].data[i];
                @(posedge tb_clk);
                @(negedge tb_clk);
            end
            tb_store_rx_packet_data = 0;
        end
    end
    endtask
    task set_expected;
        input logic Dp, Dm, transfer_active, error, get_packet_data;
    begin
        tb_expected_Dplus_out = Dp;
        tb_expected_Dminus_out = Dm;
        tb_expected_tx_transfer_active = transfer_active;
        tb_expected_tx_error = error;
        tb_expected_get_tx_packet_data = get_packet_data;
    end
    endtask
    // Note: the times check_output are called are when get_tx_packet_data are usually LOW
    task check_outputs;
        input string tag;
        logic error;
    begin
        error = 0;
        $info("CHECKINFO: %d: %s: tagged: %s", tb_test_case_num, tb_test_case_name, tag);
        assert (tb_Dplus_out == tb_expected_Dplus_out)
        else begin
            error = 1;
            $error("Incorrect Dplus_out for test case: %d: %s", tb_test_case_num, tb_test_case_name);
        end
        assert (tb_Dminus_out == tb_expected_Dminus_out)
        else begin
            error = 1;
            $error("Incorrect Dminus_out: %d: %s", tb_test_case_num, tb_test_case_name);
        end
        assert (tb_tx_transfer_active == tb_expected_tx_transfer_active)
        else begin
            error = 1;
            $error("Incorrect tx_transfer_active: %d: %s", tb_test_case_num, tb_test_case_name);
        end
        assert (tb_tx_error == tb_expected_tx_error)
        else begin
            error = 1;
            $error("Incorrect tx_error: %d: %s", tb_test_case_num, tb_test_case_name);
        end
        assert (tb_get_tx_packet_data == tb_expected_get_tx_packet_data)
        else begin
            error = 1;
            $error("Incorrect get_tx_packet_data: %d: %s", tb_test_case_num, tb_test_case_name);
        end
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
    task next_d;
        input integer i;
        input logic [7:0] data;
        input logic prev_Dp;
        input logic prev_Dm;
    begin
        if (data[i] == 0) begin
            Dp = ~prev_Dp;
            Dm = ~prev_Dm;
        end
        else begin
            Dp = prev_Dp;
            Dm = prev_Dm;
        end
    end
    endtask
    task check_byte;
        input logic [7:0] byte_to_check;
        integer i;
    begin
        for (i = 0; i < 8; i++) begin
            next_d(i, byte_to_check, Dp, Dm);
            set_expected(.Dp(Dp), .Dm(Dm), .transfer_active(1), .error(0), .get_packet_data(0));
            wait_for(4); //Wait for 4 clock cycles
            check_outputs(string'(i));
            wait_for(4); //Wait for 4 clock cycles
        end
    end
    endtask
    task check_eop;
    begin
        $info("CHECKINFO: EOP");
        //EOP1
        set_expected(.Dp(0), .Dm(0), .transfer_active(1), .error(0), .get_packet_data(0));
        wait_for(4); //Wait for 4 clock cycles
        check_outputs("EOP1");
        wait_for(4); //Wait for 4 clock cycles
        //EOP2
        set_expected(.Dp(0), .Dm(0), .transfer_active(1), .error(0), .get_packet_data(0));
        wait_for(4); //Wait for 4 clock cycles
        check_outputs("EOP2");
        wait_for(4); //Wait for 4 clock cycles
        //Mandatory IDLE
        set_expected(.Dp(1), .Dm(0), .transfer_active(1), .error(0), .get_packet_data(0));
        wait_for(4); //Wait for 4 clock cycles
        check_outputs("Mandatory IDLE");
        wait_for(4); //Wait for 4 clock cycles
        //Should now be idle
        set_expected(.Dp(1), .Dm(0), .transfer_active(0), .error(0), .get_packet_data(0));
        wait_for(1);
        check_outputs("Complete IDLE");
        tb_tx_packet = '0;
        @(posedge tb_clk);
        @(negedge tb_clk);
        check_outputs("Complete IDLE Still");
    end
    endtask
    task run_data_task;
        integer i;
    begin
        Dp = 1;
        Dm = 0;
        //Initiate send
        tb_tx_packet = DEFAULT_DATA;
        @(posedge tb_clk);
        @(negedge tb_clk);
        set_expected(.Dp(1), .Dm(0), .transfer_active(1), .error(0), .get_packet_data(0));
        check_outputs("Initial transfer active");
        //Error check takes 1 cycle for sending data!
        @(posedge tb_clk);
        @(negedge tb_clk);
        set_expected(.Dp(1), .Dm(0), .transfer_active(1), .error(0), .get_packet_data(0));
        check_outputs("No tx_error for transfer");
        //Wait till D+ goes low
        @(negedge tb_Dplus_out);
        #(0.1); //WAITS 0.1 ns AFTER FALLING EDGE OF D+
        //SYNC
        $info("CHECKINFO: Sync Byte");
        check_byte(SYNC_BYTE);
        //PID
        $info("CHECKINFO: PID");
        check_byte({~DEFAULT_DATA, DEFAULT_DATA});
        //Data
        for (i = 0; i < tb_test_vectors[tb_test_vector_num].amount; i++) begin
            $info("CHECKSTREAMHEAD: byte number: %d", i);
            check_byte(tb_test_vectors[tb_test_vector_num].data[i]);
        end
        //EOP
        check_eop();
    end
    endtask
    task run_other_packet_task;
        input integer mode; //0 is ACK, 1 is NAK
    begin
        Dp = 1;
        Dm = 0;
        if (mode == 0) begin
            tb_tx_packet = ACK;
        end
        else begin
            tb_tx_packet = NAK;
        end
        @(posedge tb_clk);
        @(negedge tb_clk);
        set_expected(.Dp(1), .Dm(0), .transfer_active(1), .error(0), .get_packet_data(0));
        check_outputs("Initial transfer active");
        //Wait till D+ goes low
        @(negedge tb_Dplus_out);
        #(0.1); //WAITS 0.1 ns AFTER FALLING EDGE OF D+
        //SYNC
        $info("CHECKINFO: Sync Byte");
        check_byte(SYNC_BYTE);
        $info("CHECKINFO: PID");
        //PID
        if (mode == 0) begin
            check_byte({~ACK, ACK});
        end
        else if (mode == 1) begin
            check_byte({~NAK, NAK});
        end
        //EOP
        check_eop();
    end
    endtask
    // ************************************************************************
    // MAIN BLOCK
    // ************************************************************************
    integer max_test_case;
    initial begin
        max_test_case = 4;
        tb_test_vectors = new[max_test_case];
        tb_test_case_num = -1;
        tb_test_vector_num = 0;
        
        tb_test_case_name = "Initialization";

        populate_sequential(7'd1, 0);
        populate_sequential(7'd21, 1);
        populate_sequential(7'd33, 2);
        populate_sequential(7'd64, 3);

        tb_n_rst = 1;
        reset_signals();
        #(0.1);
        // ************************************************************************
        // Power-on-Reset Test Case
        // ************************************************************************
        tb_test_case_name = "Power-on-Reset";
        tb_test_case_num++;
        $info("Test case number %d", tb_test_case_num);

        reset_signals();
        set_expected(.Dp(1), .Dm(0), .transfer_active(0), .error(0), .get_packet_data(0));
        reset_dut();
        check_outputs("After reset");
        // ************************************************************************
        // Test Stream
        // ************************************************************************
        tb_test_case_name = "Test Stream";
        for (tb_test_vector_num = 0; tb_test_vector_num < max_test_case; tb_test_vector_num++) begin
            tb_test_case_num++;
            $info("TESTSTREAMHEAD: Test case number %d with test vector index %d", tb_test_case_num, tb_test_vector_num);
            reset_signals();
            reset_dut();
            load_test_stream(0);
            run_data_task();
        end
        // ************************************************************************
        // Error
        // ************************************************************************
        tb_test_case_name = "tx_error";
        tb_test_case_num++;
        $info("TESTSTREAMHEAD: Test case number %d with test vector index %d", tb_test_case_num, tb_test_vector_num);
        reset_signals();
        reset_dut();
        //Initiate send
        tb_tx_packet = DEFAULT_DATA;
        @(posedge tb_clk);
        @(negedge tb_clk);
        set_expected(.Dp(1), .Dm(0), .transfer_active(1), .error(0), .get_packet_data(0));
        check_outputs("Initial transfer active");
        //Error check takes 1 cycle for sending data!
        @(posedge tb_clk);
        @(negedge tb_clk);
        set_expected(.Dp(1), .Dm(0), .transfer_active(0), .error(1), .get_packet_data(0));
        check_outputs("tx_error for transfer");
        tb_tx_packet = '0;
        @(posedge tb_clk);
        @(negedge tb_clk);
        set_expected(.Dp(1), .Dm(0), .transfer_active(0), .error(1), .get_packet_data(0));
        check_outputs("tx_error should hold");
        // ************************************************************************
        // ACK
        // ************************************************************************
        tb_test_case_name = "ACK";
        tb_test_case_num++;
        $info("TESTSTREAMHEAD: Test case number %d with test vector index %d", tb_test_case_num, tb_test_vector_num);
        reset_signals();
        reset_dut();
        run_other_packet_task(0);
        // ************************************************************************
        // NAK
        // ************************************************************************
        tb_test_case_name = "NAK";
        tb_test_case_num++;
        $info("TESTSTREAMHEAD: Test case number %d with test vector index %d", tb_test_case_num, tb_test_vector_num);
        reset_signals();
        reset_dut();
        run_other_packet_task(1);
        // ************************************************************************
        // END
        // ************************************************************************
        $info("END OF ALL TEST CASES");
    end

endmodule
