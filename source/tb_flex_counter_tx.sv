// $Id: $
// File name:   tb_flex_counter.sv
// Created:     2/3/2022
// Author:      Justin Lee
// Lab Section: 337-016
// Version:     1.0  Initial Design Entry
// Description: A flex counter testbench
`timescale 1ns / 10ps

module tb_flex_counter (

);
    // Local params
    localparam NUM_CNT_BITS = 4;
    localparam BIT_MAX = NUM_CNT_BITS - 1;

    localparam CLK_PERIOD = 2.5;
    localparam HALF_CLK_PERIOD = 1.25;
    localparam FF_SETUP_TIME = 0.190;
    localparam FF_HOLD_TIME = 0.100;
    localparam CHECK_DELAY = (CLK_PERIOD - FF_SETUP_TIME);

    localparam INACTIVE_VALUE = 1'b0;
    localparam RESET_COUNT = NUM_CNT_BITS'('b0); 
    localparam RESET_OUTPUT_VALUE = INACTIVE_VALUE;
    localparam ACTIVE_VALUE = 1'b1;

    // DUT portmap signals
    logic tb_clk;
    logic tb_n_rst;
    logic tb_clear;
    logic tb_count_enable;
    logic [BIT_MAX:0] tb_rollover_val;
    logic [BIT_MAX:0] tb_count_out;
    logic tb_rollover_flag;

    // tb specific signals
    integer tb_test_num;
    string tb_test_case;
    string tb_count_to;
    logic [BIT_MAX:0] i;

    // Task for standard DUT reset procedure
    task reset_dut;
    begin
        // Activate the reset
        tb_n_rst = 1'b0;

        // Maintain the reset for more than one cycle
        @(posedge tb_clk);
        @(posedge tb_clk);

        // Wait until safely away from rising edge of the clock before releasing
        @(negedge tb_clk);
        tb_n_rst = 1'b1;

        // Leave out of reset for a couple cycles before allowing other stimulus
        // Wait for negative clock edges, 
        // since inputs to DUT should normally be applied away from rising clock edges
        @(negedge tb_clk);
        @(negedge tb_clk);
    end
    endtask
    // Task to cleanly and consistently check DUT output values
    task check_output;
        input logic [BIT_MAX:0]  expected_count;
        input logic expected_rollover_flag;
        input string check_tag;
    begin
        if(expected_count == tb_count_out) begin // Check passed
        $info("Correct count output %s during %s test case", check_tag, tb_test_case);
        end
        else begin // Check failed
        $error("Incorrect count output %s during %s test case, got %d", check_tag, tb_test_case, tb_count_out);
        end
        if(expected_rollover_flag == tb_rollover_flag) begin // Check passed
        $info("Correct rollover flag output %s during %s test case", check_tag, tb_test_case);
        end
        else begin // Check failed
        $error("Incorrect rollover flag output %s during %s test case", check_tag, tb_test_case);
        end
    end
    endtask
    // Task to clear
    task clear_dut;
    begin
        // Wait till neg edge
        @(negedge tb_clk);
        tb_clear = 1'b1;
        //1 rising edges
        @(posedge tb_clk);
        // Wait till neg edge
        @(negedge tb_clk);
        tb_clear = 1'b0;
    end 
    endtask

    // Clock generation block
    always
    begin
        // Start with clock low to avoid false rising edge events at t=0
        tb_clk = 1'b0;
        // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
        #(CLK_PERIOD/2.0);
    end


    // DUT Port map
    //flex_counter #(.NUM_CNT_BITS(NUM_CNT_BITS)) DUT(.clk(tb_clk), .n_rst(tb_n_rst), .clear(tb_clear), .count_enable(tb_count_enable), .rollover_val(tb_rollover_val), .count_out(tb_count_out), .rollover_flag(tb_rollover_flag));
    //In mapped version, NUM_CNT_BITS no longer defined!!
    flex_counter DUT(.clk(tb_clk), .n_rst(tb_n_rst), .clear(tb_clear), .count_enable(tb_count_enable), .rollover_val(tb_rollover_val), .count_out(tb_count_out), .rollover_flag(tb_rollover_flag));

    // Test bench stuff
    initial begin
        // Initialize all inputs
        tb_n_rst = 1'b1;
        tb_rollover_val = NUM_CNT_BITS'('b1); //Maximum value so rollover flag is not triggerred
        tb_clear = 1'b0;
        tb_count_enable = 1'b0;

        // Initialize test bench specific
        tb_test_num = 0;
        tb_test_case = "Test bench initialization";
        // Wait
        #(0.1); 

        // ************************************************************************
        // Test Case 1: Power-on Reset of the DUT  
        // ************************************************************************
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Power on Reset";
        #(0.1); 
        //Set inputs
        tb_count_enable = 1'b0; //Don't enable the count?
        tb_n_rst = 1'b0;

        #(CLK_PERIOD * 0.5)

        check_output(RESET_COUNT, RESET_OUTPUT_VALUE, "after reset applied");

        #(CLK_PERIOD);

        check_output(RESET_COUNT, RESET_OUTPUT_VALUE, "after clock cycle while reset");

        @(posedge tb_clk);
        #(2 * FF_HOLD_TIME);
        tb_n_rst = 1'b1;
        #0.1
        check_output(RESET_COUNT, RESET_OUTPUT_VALUE, "after reset was released");
        tb_count_enable = 1'b0;

        // ************************************************************************
        // Test Case 2: Rollover for rollover value not power of two 
        // ************************************************************************
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Rollover not power of 2";
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();

        tb_rollover_val = NUM_CNT_BITS'(2'b11); 
        tb_count_enable = 1'b1;

        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), INACTIVE_VALUE, "count to 1");
        @(posedge tb_clk); //2
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(2'd2), INACTIVE_VALUE, "count to 2");
        @(posedge tb_clk); //3
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd3), ACTIVE_VALUE, "count to 3");
        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), INACTIVE_VALUE, "count to 1");
        @(posedge tb_clk); //2
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(2'd2), INACTIVE_VALUE, "count to 2");

        // ************************************************************************
        // Test Case 3: Rollover for rollover value power of two 
        // ************************************************************************
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Rollover power of 2";
        tb_count_to = "count to";
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();

        tb_rollover_val = NUM_CNT_BITS'(4'd8); 
        tb_count_enable = 1'b1;

        for (i = 1; i < 8; i++) begin
            @(posedge tb_clk);
            $sformat(tb_count_to, "count to %d", i);
            #(CHECK_DELAY);
            check_output(NUM_CNT_BITS'(i), INACTIVE_VALUE, tb_count_to);
        end
        @(posedge tb_clk);
        $sformat(tb_count_to, "count to %d", i); //i == 8
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(i), ACTIVE_VALUE, tb_count_to);
        for (i = 1; i < 3; i++) begin
            @(posedge tb_clk);
            $sformat(tb_count_to, "count to %d", i);
            #(CHECK_DELAY);
            check_output(NUM_CNT_BITS'(i), INACTIVE_VALUE, tb_count_to);
        end
        // ************************************************************************
        // Test Case 4: Clear while counting to check priority
        // ************************************************************************
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Clear while Counting";
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();

        tb_rollover_val = NUM_CNT_BITS'(4'd2); 
        tb_count_enable = 1'b1;

        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), INACTIVE_VALUE, "count to 1");

        clear_dut();
        #(CHECK_DELAY - HALF_CLK_PERIOD); //Since clear DUT goes to negedge
        check_output(NUM_CNT_BITS'(1'b0), INACTIVE_VALUE, "count to 0");

        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), INACTIVE_VALUE, "count to 1");
        @(posedge tb_clk); //2
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd2), ACTIVE_VALUE, "count to 2");
        // ************************************************************************
        // Test Case 5: Rollover value of 1 
        // ************************************************************************
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Rollover of 1";
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();

        tb_rollover_val = NUM_CNT_BITS'(4'd1); 
        tb_count_enable = 1'b1;

        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), ACTIVE_VALUE, "count to 1");
        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), ACTIVE_VALUE, "count to 1");
        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), ACTIVE_VALUE, "count to 1");

        clear_dut();
        #(CHECK_DELAY - HALF_CLK_PERIOD); //Since clear DUT goes to negedge
        check_output(NUM_CNT_BITS'(1'b0), INACTIVE_VALUE, "count to 0");

        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), ACTIVE_VALUE, "count to 1");
        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), ACTIVE_VALUE, "count to 1");

        // ************************************************************************
        // Test Case 6: Rollover value of 0
        // ************************************************************************
        //UNDEFINED BEHAVIOR?!?!?!

        tb_test_num = tb_test_num + 1;
        tb_test_case = "Rollover of 0";
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();
        
        tb_rollover_val = NUM_CNT_BITS'(4'd0); 
        tb_count_enable = 1'b1;

        //Should wrap back to 0 instead or keep counting up forever?
        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), INACTIVE_VALUE, "count to 1");
        //...

        // ************************************************************************
        // Test Case 7: Continuous Counting
        // ************************************************************************
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Continuous Counting";
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();

        tb_rollover_val = NUM_CNT_BITS'(4'd7); 
        tb_count_enable = 1'b1;

        for (i = 1; i < 7; i++) begin
            @(posedge tb_clk);
            $sformat(tb_count_to, "count to %d", i);
            #(CHECK_DELAY);
            check_output(NUM_CNT_BITS'(i), INACTIVE_VALUE, tb_count_to);
        end
        @(posedge tb_clk);
        $sformat(tb_count_to, "count to %d", i); //i == 7
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(i), ACTIVE_VALUE, tb_count_to);
        for (i = 1; i < 4; i++) begin
            @(posedge tb_clk);
            $sformat(tb_count_to, "count to %d", i);
            #(CHECK_DELAY);
            check_output(NUM_CNT_BITS'(i), INACTIVE_VALUE, tb_count_to);
        end
        // ************************************************************************
        // Test Case 8: Discontinuous Counting
        // ************************************************************************
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Discontinuous Counting";
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();

        tb_rollover_val = NUM_CNT_BITS'(4'd5); 
        tb_count_enable = 1'b1;

        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), INACTIVE_VALUE, "count to 1");

        @(posedge tb_clk); //2
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        #(CHECK_DELAY - HALF_CLK_PERIOD);
        check_output(NUM_CNT_BITS'(4'd2), INACTIVE_VALUE, "count to 2-disable");

        @(posedge tb_clk); //2
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd2), INACTIVE_VALUE, "count to 2-disable");
        @(posedge tb_clk); //2
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd2), INACTIVE_VALUE, "count to 2-disable");

        @(posedge tb_clk); //2
        @(negedge tb_clk);
        tb_count_enable = 1'b1;
        @(posedge tb_clk); //3
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd3), INACTIVE_VALUE, "count to 3-enable");
        @(posedge tb_clk); //4
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd4), INACTIVE_VALUE, "count to 4-enable");
        // ************************************************************************
        // Test Case 9: Rollover flag while count == rollover value and count disabled
        // ************************************************************************
        tb_test_num = tb_test_num + 1;
        tb_test_case = "Rollover while count disabled";
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();

        tb_rollover_val = NUM_CNT_BITS'(4'd3); 
        tb_count_enable = 1'b1;

        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), INACTIVE_VALUE, "count to 1");
        @(posedge tb_clk); //2
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd2), INACTIVE_VALUE, "count to 2");

        @(negedge tb_clk); //3
        tb_count_enable = 1'b0;
        @(posedge tb_clk); //3
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd3), ACTIVE_VALUE, "count to 3");
        @(posedge tb_clk); //3
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(4'd3), ACTIVE_VALUE, "count to 3");
        @(negedge tb_clk); //3
        tb_count_enable = 1'b1;
        @(posedge tb_clk); //1
        #(CHECK_DELAY);
        check_output(NUM_CNT_BITS'(1'b1), INACTIVE_VALUE, "count to 1");
         
        // ************************************************************************
        // CLOSING
        // ************************************************************************
        @(negedge tb_clk);
        tb_count_enable = 1'b0;
        reset_dut();

        $info("End of test cases");
    end
endmodule