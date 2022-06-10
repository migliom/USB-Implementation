// $Id: $
// File name:   tb_ahb_slave.sv
// Created:     4/23/2022
// Author:      Ansh Patel
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test bench for AHB Lite module

`timescale 1ns / 10ps
module tb_ahb_slave ();
// Timing related constants
localparam CLK_PERIOD = 10;
localparam BUS_DELAY  = 800ps; // Based on FF propagation delay

// Sizing related constants
localparam DATA_WIDTH      = 4;
localparam ADDR_WIDTH      = 4;
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

// Packet ID
localparam OUT   = 4'b0001;
localparam IN    = 4'b1001;
localparam DATA0 = 4'b0011;
localparam DATA1 = 4'b1011;
localparam ACK   = 4'b0010;
localparam NAK   = 4'b1010;
localparam STALL = 4'b1110;

// RX signals
logic [3:0] rx_packet;
logic rx_data_ready;
logic rx_transfer_active;
logic rx_error;

// Data buffer signals
logic [6:0] buffer_occupancy;
logic [7:0] rx_data;
logic get_rx_data;
logic store_tx_data;
logic [7:0] tx_data;
logic clear;

// TX signals
logic [3:0] tx_packet;
logic tx_transfer_active;
logic tx_error;

// D mode
logic d_mode;

// Expected output
logic       expected_get_rx_data;
logic       expected_store_tx_data;
logic [7:0] expected_tx_data;
logic       expected_clear;
logic [3:0] expected_tx_packet;
logic       expected_d_mode;

// AHB-Lite-Slave reset value constants
// Student TODO: Update these based on the reset values for your config registers
localparam RESET_VALUE  = '0;


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
integer  tb_current_transaction_num;
logic    tb_current_transaction_error;
logic    tb_model_reset;
string   tb_test_case;
integer  tb_test_case_num;
bit   [DATA_MAX_BIT:0] tb_test_data [];
string                 tb_check_tag;
logic                  tb_mismatch;
logic                  tb_check;

//*****************************************************************************
// General System signals
//*****************************************************************************
logic tb_clk;
logic tb_n_rst;

//*****************************************************************************
// AHB-Lite-Slave side signals
//*****************************************************************************
logic                  tb_hsel;
logic [1:0]            tb_htrans;
logic [ADDR_MAX_BIT:0] tb_haddr;
logic [2:0]            tb_hsize;
logic                  tb_hwrite;
logic [DATA_MAX_BIT:0] tb_hwdata;
logic [DATA_MAX_BIT:0] tb_hrdata;
logic                  tb_hresp;

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
// Bus Model Instance
//*****************************************************************************

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

//*****************************************************************************
// DUT Instance
//*****************************************************************************
ahb_slave DUT (.clk(tb_clk), .n_rst(tb_n_rst),
              // RX SIGNALS
              .rx_packet(rx_packet),
              .rx_data_ready(rx_data_ready),
              .rx_transfer_active(rx_transfer_active),
              .rx_error(rx_error),
              // TX SIGNALS
              .tx_error(tx_error),
              .tx_transfer_active(tx_transfer_active),
              .tx_packet(tx_packet),
              // DATA BUFFER
              .buffer_occupancy(buffer_occupancy),
              .rx_data(rx_data),
              .get_rx_data(get_rx_data),
              .store_tx_data(store_tx_data),
              .tx_data(tx_data),
              .clear(clear),
              // AHB-Lite-Slave bus signals
              .hsel(tb_hsel),
              .htrans(tb_htrans),
              .haddr(tb_haddr),
              .hsize(tb_hsize[1:0]),
              .hwrite(tb_hwrite),
              .hwdata(tb_hwdata),
              .hrdata(tb_hrdata),
              .hresp(tb_hresp)
              );

//*****************************************************************************
// DUT Related TB Tasks
//*****************************************************************************
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
task check_outputs;
  input string check_tag;
begin
  tb_mismatch = 1'b0;
  tb_check    = 1'b1;
  if(expected_get_rx_data == get_rx_data) begin // Check passed
    $info("Correct 'get_rx_data' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'get_rx_data' output %s during %s test case", check_tag, tb_test_case);
  end

  if(expected_store_tx_data == store_tx_data) begin // Check passed
    $info("Correct 'store_tx_data' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'store_tx_data' output %s during %s test case", check_tag, tb_test_case);
  end

  if(expected_tx_data == tx_data) begin // Check passed
    $info("Correct 'tx_data' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'tx_data' output %s during %s test case", check_tag, tb_test_case);
  end

  if(expected_clear == clear) begin // Check passed
    $info("Correct 'clear' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'clear' output %s during %s test case", check_tag, tb_test_case);
  end

  if(expected_tx_packet == tx_packet) begin // Check passed
    $info("Correct 'tx_packet' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'tx_packet' output %s during %s test case", check_tag, tb_test_case);
  end

  // Wait some small amount of time so check pulse timing is visible on waves
  #(0.1);
  tb_check =1'b0;
end
endtask

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
    @(posedge tb_clk);
  end

  // Run out the last one (currently in data phase)
  @(posedge tb_clk);

  // Turn off the bus model
  @(negedge tb_clk);
  tb_enable_transactions = 1'b0;
end
endtask

// Task to clear/initialize all FIR-side inputs
task init_inputs;
begin
  rx_packet          = '0;
  rx_data_ready      = '0;
  rx_transfer_active = '0;
  rx_error           = '0;
  buffer_occupancy   = '0;
  rx_data            = '0;
  tx_transfer_active = '0;
  tx_error           = '0;
end
endtask

// Task to clear/initialize all FIR-side inputs
task init_expected_outs;
begin
  expected_get_rx_data   = '0;
  expected_store_tx_data = '0;
  expected_tx_data       = '0;
  expected_clear         = '0;
  expected_tx_packet     = '0;
  expected_d_mode        = '0;
end
endtask

//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
  // Initialize Test Case Navigation Signals
  tb_test_case       = "Initilization";
  tb_test_case_num   = -1;
  tb_test_data       = new[1];
  tb_check_tag       = "N/A";
  tb_check           = 1'b0;
  tb_mismatch        = 1'b0;
  // Initialize all of the directly controled DUT inputs
  tb_n_rst          = 1'b1;
  init_inputs();
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

  //*****************************************************************************
  // Power-on-Reset Test Case
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Power-on-Reset";
  tb_test_case_num = tb_test_case_num + 1;
  
  // Setup provided input signals with 'active' values for reset check
  rx_packet          = '1;
  rx_data_ready      = '1;
  rx_transfer_active = '1;
  rx_error           = '1;
  buffer_occupancy   = '1;
  rx_data            = '1;
  tx_transfer_active = '0;
  tx_error           = '1;

  // Reset the DUT
  reset_dut();

  // Check outputs for reset state
  init_expected_outs();
  expected_d_mode = 1'b1;
  check_outputs("after DUT reset");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  // Test Case: Write 4 Bytes TX Data
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write 4 TX Data";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  //tb_test_data = '{32'd19000000}; 
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{32'd19000000}, 1'b0, 2'd2);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  expected_tx_packet = DATA0;
  check_outputs("after Write 1 TX Control Reg");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 8);

  //*****************************************************************************
  // Test Case: Write 2 Bytes TX Data
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write 2 TX Data";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions (Low Coeff Address => F0, just add 2 x index)
  tb_test_data = '{32'd8000004};
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND+1, '{32'd8000004}, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  expected_tx_packet = ACK;
  check_outputs("after Write 2 TX Control Reg");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 5);

  //*****************************************************************************
  // Test Case: Write 1 Byte TX Data
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write 1 TX Data";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions (Low Coeff Address => F0, just add 2 x index)
  tb_test_data = '{32'd7000000}; 
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND+1, '{32'd7000000}, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  //tx_transfer_active = 1'b1;
  expected_tx_packet = STALL;
  check_outputs("after Write 4 TX Control Reg");

  // Check reset
  //repeat(3) @(posedge tb_clk);
  //@(negedge tb_clk);
  //tx_transfer_active = 1'b0;
  //repeat (2) @(posedge tb_clk);
  //expected_tx_packet = '0;
  //#(BUS_DELAY*3);
  //check_outputs("after CLEAR 4 TX Control Reg");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 8);

  //*****************************************************************************
  // Test Case: Write FLUSH
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write FLUSH";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  buffer_occupancy = 6;
  tb_test_data = '{32'd1}; 
  enqueue_transaction(1'b1, 1'b1, FLUSH_CONTROL_IND, '{32'd1}, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  expected_clear = 1'b1;
  check_outputs("after Write FLUSH");

  // Check reset
  repeat(3) @(posedge tb_clk);
  @(negedge tb_clk);
  buffer_occupancy = '0;
  repeat (2) @(posedge tb_clk);
  #(BUS_DELAY);
  expected_clear = 1'b0;
  check_outputs("after CLEAR FLUSH");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 5);

  //*****************************************************************************
  // Test Case: Write to INVALID ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write to INVALID ADDR";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{32'hFFFFFFF3};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b1, 4'd15, '{32'hFFFFFFF3}, 1'b1, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("Write to INVALID ADDR");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 3);

  //*****************************************************************************
  // Test Case: READ DATA BUFFER
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Read 4 Bytes Data Buffer";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set up rx_data from data buffer
  rx_data = 8'h11;

  // Write 1 to the READ_STATUS_REG
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, '{32'h00010000}, 1'b0, 2'd2);
  // Run the transactions via the model
  execute_transactions(1);

  /*repeat (2) @(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, '0, 1'b0, 2'd0);
  execute_transactions(1);

  tb_test_data = 32'h00000011; 
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, tb_test_data, 1'b0, 2'd0);
  execute_transactions(1);
  */

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 6);


  //*****************************************************************************
  // Test Case: READ DATA BUFFER
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Read 2 Bytes Data Buffer";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set up rx_data from data buffer
  rx_data = 8'h11;

  // Write 1 to the READ_STATUS_REG
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, '{32'h00010000}, 1'b0, 2'd1);
  // Run the transactions via the model
  execute_transactions(1);

  /*repeat (2) @(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, '0, 1'b0, 2'd0);
  execute_transactions(1);

  tb_test_data = 32'h00000011; 
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, tb_test_data, 1'b0, 2'd0);
  execute_transactions(1);
  */

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 6);

  //*****************************************************************************
  // Test Case: READ DATA BUFFER
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Read Status Register";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set up rx_data from data buffer
  rx_packet = IN;

  // Write 1 to the READ_STATUS_REG
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, '{32'd1}, 1'b0, 2'd0);
  // Run the transactions via the model
  execute_transactions(1);

  /*repeat (2) @(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, '0, 1'b0, 2'd0);
  execute_transactions(1);

  tb_test_data = 32'h00000011; 
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, tb_test_data, 1'b0, 2'd0);
  execute_transactions(1);
  */

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 6);

  //*****************************************************************************
  // Test Case: RAW HAZARD
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "RAW HAZARD";
  tb_test_case_num = tb_test_case_num + 1;
  init_inputs();
  init_expected_outs();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions (Low Coeff Address => F0, just add 2 x index)
  tb_test_data = '{32'h00000004}; 
  enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{32'h00000004}, 1'b0, 2'd0);
  enqueue_transaction(1'b1, 1'b0, TX_CONTROL_IND, '{32'h00000004}, 1'b0, 2'd0);  
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  // tx_transfer_active = 1'b1;
  expected_tx_packet = STALL;
  check_outputs("RAW HAZARD");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 5);

$stop();
end

endmodule