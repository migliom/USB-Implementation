// $Id: $
// File name:   tb_fifo_data_buffer.sv
// Created:     4/20/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: Test bench for the FIFO data buffer

`timescale 1ns/10ps

module tb_fifo_data_buffer ();
    // CONSTANTS
    localparam CLK_PERIOD = 10;

    // TEST BENCH Signals
    logic tb_clk;
    logic tb_n_rst;

    integer tb_test_case_num;
    integer tb_test_vector_num;
    string tb_test_case;

    logic [7:0] tb_expected_rx_data, tb_expected_tx_packet_data;
    logic [6:0] tb_expected_buffer_occupancy;

    // DUT SIGNALS
    logic tb_clear, tb_flush, tb_store_tx_data, tb_store_rx_packet_data, tb_get_rx_data, tb_get_tx_packet_data;
    logic [7:0] tb_tx_data, tb_rx_packet_data;
    logic [7:0] tb_rx_data, tb_tx_packet_data;
    logic [6:0] tb_buffer_occupancy;
    // ************************************************************************
    // Test Vector
    // ************************************************************************
    typedef struct {
        logic [7:0] data[63:0];
        logic [6:0] amount;
    } testVector;
    testVector tb_test_vectors[];
    
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
    // DUT
    // ************************************************************************
    fifo_data_buffer DUT ( .clear(tb_clear),
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
    task reset_inputs;
    begin
        tb_get_rx_data = 0;
        tb_get_tx_packet_data = 0;
        tb_store_rx_packet_data = 0;
        tb_store_tx_data = 0;
        tb_clear = 0;
        tb_flush = 0;
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
    // ************************************************************************
    // NOTE: update check_task so it acts like a state machine is inputting to it
    // ************************************************************************
    
    task check_task;
        input logic mode; // 0 is get_tx_packet_data, 1 is get_rx_data
        integer i;
    begin
        tb_get_rx_data = 0;
        tb_get_tx_packet_data = 0;
        @(negedge tb_clk);
        tb_expected_buffer_occupancy = tb_test_vectors[tb_test_vector_num].amount;
        assert (tb_expected_buffer_occupancy == tb_buffer_occupancy)
        else begin
            $error("Wrong buffer occupancy for initial check", i);
        end
        @(posedge tb_clk);
        #(2.0);
        //State machines should output gets slightly after rising edge
        if (mode == 0) begin
            for (i = 0; i < tb_test_vectors[tb_test_vector_num].amount; i++) begin
                tb_get_tx_packet_data = 1;
                tb_get_rx_data = 0;
                tb_expected_tx_packet_data = tb_test_vectors[tb_test_vector_num].data[i];
                tb_expected_rx_data = '0;
                tb_expected_buffer_occupancy = tb_expected_buffer_occupancy - 1;
                @(posedge tb_clk);
                #(0.8);
                //Inputs to registers on rising edge before and after should be stable.
                //Note: buffer occupancy updates AFTER rising edge!!
                assert (tb_expected_tx_packet_data == tb_tx_packet_data) 
                else begin
                    $error("Wrong tx_packet_data for byte index %d, Mode to receive this", i);
                end
                assert (tb_expected_rx_data == tb_rx_data)
                else begin
                    $error("Wrong rx_data for byte index %d, Mode to not receive this", i);
                end
                assert (tb_expected_buffer_occupancy == tb_buffer_occupancy)
                else begin
                    $error("Wrong buffer occupancy for byte index %d", i);
                end
                @(negedge tb_clk);
            end
        end
        else begin
            for (i = 0; i < tb_test_vectors[tb_test_vector_num].amount; i++) begin
                tb_get_tx_packet_data = 0;
                tb_get_rx_data = 1;
                tb_expected_rx_data = tb_test_vectors[tb_test_vector_num].data[i];
                tb_expected_tx_packet_data = '0;
                tb_expected_buffer_occupancy = tb_expected_buffer_occupancy - 1;
                @(posedge tb_clk);
                #(0.8);
                assert (tb_expected_tx_packet_data == tb_tx_packet_data) 
                else begin
                    $error("Wrong tx_packet_data for byte index %d, Mode to not receive this", i);
                end
                assert (tb_expected_rx_data == tb_rx_data)
                else begin
                    $error("Wrong rx_data for byte index %d, Mode to receive this", i);
                end
                assert (tb_expected_buffer_occupancy == tb_buffer_occupancy)
                else begin
                    $error("Wrong buffer occupancy for byte index %d", i);
                end
                @(negedge tb_clk);
            end
        end
        tb_get_rx_data = 0;
        tb_get_tx_packet_data = 0;
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
        
        tb_test_case = "Initialization";

        populate_sequential(7'd17, 0);
        populate_sequential(7'd64, 1);
        populate_sequential(7'd33, 2);
        populate_sequential(7'd64, 3);

        tb_n_rst = 1;
        reset_inputs();
        #(0.1);
        // ************************************************************************
        // Power-on-Reset Test Case
        // ************************************************************************
        tb_test_case = "Power-on-Reset";
        tb_test_case_num++;
        $info("Test case number %d", tb_test_case_num);

        reset_dut();
        tb_expected_rx_data = '0;
        tb_expected_tx_packet_data = '0;
        tb_expected_buffer_occupancy = '0;
        assert (tb_expected_tx_packet_data == tb_tx_packet_data) 
        else begin
            $error("Wrong tx_packet_data for %s", tb_test_case);
        end
        assert (tb_expected_rx_data == tb_rx_data)
        else begin
            $error("Wrong rx_data for %s", tb_test_case);
        end
        assert (tb_expected_buffer_occupancy == tb_buffer_occupancy)
        else begin
            $error("Wrong buffer occupancy for %s", tb_test_case);
        end

        #(CLK_PERIOD * 3);
        // ************************************************************************
        // Test Stream
        // ************************************************************************
        for (tb_test_vector_num = 0; tb_test_vector_num < 2; tb_test_vector_num++) begin
            tb_test_case_num++;
            $info("Test case number %d with test vector index %d", tb_test_case_num, tb_test_vector_num);
            reset_inputs();
            reset_dut();
            load_test_stream(0);
            check_task(0);
        end
        for (tb_test_vector_num = 2; tb_test_vector_num < max_test_case; tb_test_vector_num++) begin
            tb_test_case_num++;
            $info("Test case number %d with test vector index %d", tb_test_case_num, tb_test_vector_num);
            reset_inputs();
            reset_dut();
            load_test_stream(1);
            check_task(1);
        end
        // ************************************************************************
        // Clear
        // ************************************************************************
        tb_test_case_num++;
        $info("Test case number %d", tb_test_case_num);
        reset_inputs();
        reset_dut();
        tb_test_vector_num = 0;
        load_test_stream(0);        
        @(negedge tb_clk);
        tb_clear = 1'b1;
        @(posedge tb_clk); 
        tb_expected_buffer_occupancy = 0;
        @(negedge tb_clk);        
        assert (tb_expected_buffer_occupancy == tb_buffer_occupancy)
        else begin
            $error("Wrong buffer occupancy for %s", tb_test_case);
        end
        tb_clear = 1'b0;
        // ************************************************************************
        // Flush
        // ************************************************************************
        tb_test_case_num++;
        $info("Test case number %d", tb_test_case_num);
        reset_inputs();
        reset_dut();
        tb_test_vector_num = 0;
        load_test_stream(0);        
        @(negedge tb_clk);
        tb_flush = 1'b1;
        @(posedge tb_clk); 
        tb_expected_buffer_occupancy = 0;
        @(negedge tb_clk);        
        assert (tb_expected_buffer_occupancy == tb_buffer_occupancy)
        else begin
            $error("Wrong buffer occupancy for %s", tb_test_case);
        end
        tb_flush = 1'b0;
                
        $info("End of all test cases");
    end
    
    
endmodule
