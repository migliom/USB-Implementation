// $Id: $
// File name:   tb_usb_rx.sv
// Created:     4/21/2022
// Author:      Matteo Miglio
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: tb

`timescale 1ns / 10ps

module tb_usb_rx();

// Timing related constants
  localparam CLK_PERIOD = 10;
  localparam DATA_PERIOD  = (8 * CLK_PERIOD);

  // PID constants are sent four bits in table right to left followed by complemented four bits right to left
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
//*****************************************************************************
// Declare TB Signals (Bus Model Controls)
//*****************************************************************************
// Testing setup signals
logic [3:0]             tb_expected_rx_packet;
logic                   tb_expected_rx_data_ready;
logic                   tb_expected_rx_transfer_active;
logic                   tb_expected_rx_error;
logic                   tb_expected_store_rx_packet_data;
logic                   tb_expected_flush;
logic [7:0]             tb_expected_rx_packet_data;

// Testing control signal(s)
logic    tb_model_reset;
string   tb_test_case;
integer  tb_test_case_num;
string   tb_check_tag;
logic    tb_mismatch;
logic    tb_check;

//*****************************************************************************
// General System signals
//*****************************************************************************
logic tb_clk;
logic tb_n_rst;

//*****************************************************************************
// RX DUT Signals 
//*****************************************************************************
logic tb_dplus_in;
logic tb_dminus_in;
logic [6:0] tb_buffer_occupancy;
logic tb_rx_transfer_active;
logic tb_rx_error;
logic tb_flush;
logic tb_receiving;
logic tb_store_rx_packet_data;
logic tb_rx_data_ready;
logic [3:0] tb_rx_packet;
logic [7:0] tb_rx_packet_data;


typedef struct
{
  logic [7:0] tb_sync_in = 8'b10000000;

  logic [5:0][7:0] tb_pid_in = {PID_OUT, PID_IN, PID_DATA0, PID_DATA1,PID_ACK, ENCODED_PID_NACK};

  logic [5:0][7:0] tb_pid_in_encoded = {ENCODED_PID_OUT, 
          ENCODED_PID_IN, ENCODED_PID_DATA0, ENCODED_PID_DATA1,
          ENCODED_PID_ACK, ENCODED_PID_NACK};

  logic [63:0][7:0] tb_test_data_in;
  //logic [63:0][7:0] tb_test_data_in_encoded;
} testVector;

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
// DUT Instance
//*****************************************************************************
usb_rx DUT (.clk(tb_clk), .n_rst(tb_n_rst),
                    // AHB-Lite-Slave bus signals
                    .dplus_in(tb_dplus_in),
                    .dminus_in(tb_dminus_in),
                    .buffer_occupancy(tb_buffer_occupancy),
                    .rx_transfer_active(tb_rx_transfer_active),
                    .rx_error(tb_rx_error),
                    .flush(tb_flush),
                    .store_rx_packet_data(tb_store_rx_packet_data),
                    .rx_data_ready(tb_rx_data_ready),
                    .rx_packet(tb_rx_packet),
                    .rx_packet_data(tb_rx_packet_data));

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
  tb_dplus_in = 1'b1;
  tb_dminus_in = 1'b0;
  // Leave out of reset for a couple cycles before allowing other stimulus
  // Wait for negative clock edges,
  // since inputs to DUT should normally be applied away from rising clock edges
  @(negedge tb_clk);
  @(negedge tb_clk);
end
endtask

// Task to clear/initialize all FIR-side inputs
task check_outputs;
  input string check_tag;
begin

  tb_mismatch = 1'b0;
  tb_check    = 1'b1;
  if(tb_expected_rx_data_ready == tb_rx_data_ready) begin // Check passed
    $info("Correct 'data_ready' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'data_ready' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_rx_packet_data == tb_rx_packet_data) begin // Check passed
    $info("Correct 'RX PACKET DATA' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'RX PACKET DATA' output %s during %s test case", check_tag, tb_test_case);
  end
  /*
  if(tb_expected_rx_transfer_active == tb_rx_transfer_active) begin // Check passed
    $info("Correct 'rx_transfer_active' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'rx_transfer_active' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_rx_error == tb_rx_error) begin // Check passed
    $info("Correct 'rx_error' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'rx_error' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_store_rx_packet_data == tb_store_rx_packet_data) begin // Check passed
    $info("Correct 'expected_store' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'expected_store' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_flush == tb_flush) begin // Check passed
    $info("Correct 'flush' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'flush' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_rx_packet == tb_rx_packet) begin // Check passed
    $info("Correct 'pid_rx_packet' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'pid_rx_packet' output %s during %s test case", check_tag, tb_test_case);
  end*/
  // Wait some small amount of time so check pulse timing is visible on waves
  #(0.1);
  tb_check =1'b0;
end
endtask
//*****************************************************************************
// Bus Model Usage Related TB Tasks
//*****************************************************************************
// Task to pulse the reset for the bus model

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

  //TASK TO SEND AN ERROR CAUSING EOP VALUE
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

task send_sync;
  input testVector tester;
  integer i;
  static logic [7:0]sync_byte = '1;
begin
  @(negedge tb_clk)

  for (i = 0; i < 8; i = i+1) begin
    tb_dplus_in = sync_byte[i];
    tb_dminus_in = ~sync_byte[i];
    #(DATA_PERIOD);
  end

end
endtask

task send_pid;
  input testVector tester;
  input integer input_pid;
  integer j;
begin
  @(negedge tb_clk)
  for(j = 0; j < 8; j=j+1) begin
    tb_dplus_in = tester.tb_pid_in_encoded[input_pid][j];
    tb_dminus_in = ~tester.tb_pid_in_encoded[input_pid][j];
    #(DATA_PERIOD);
  end



end
endtask

task send_packet_data;
  integer i;
  input logic [7:0] data;
begin
// Send data bits
for (i = 0; i < 8; i = i+1) begin
  tb_dplus_in = data[i];
  tb_dminus_in = ~data[i];
  #(DATA_PERIOD);
end

end
endtask

task send_eop;
begin
  // First synchronize away from clock's rising edge
  @(negedge tb_clk);

  // Send EOP Sequence
  tb_dplus_in = 1'b0;
  tb_dminus_in = 1'b0;
  #(DATA_PERIOD);
  
  tb_dplus_in = 1'b1;
  tb_dminus_in = 1'b0;
  #(DATA_PERIOD);
  //how to in keep it in idle instead of detecting an edge?
end
endtask

task decode_data;
  input [63:0][7:0] data;
  input testVector tester;
  integer i;
  integer j;
begin
for (i = 0; i < 64; i++) begin
  for (j = 0; j < 8; j++) begin
  // Handle special case where it is the first bit of first byte after PID byte
    if ((i == 0) && (j == 0)) begin
      if (data[0][0]) tester.tb_test_data_in[0][0] = 1'b0;
      else tester.tb_test_data_in[0][0] = 1'b1;
    end
// Handle case where it is the first bit of a non-first-byte byte
    else if (j == 0) begin
      if ((data[i-1][7] && data[i][j]) || (!data[i-1][7] && !data[i][j])) tester.tb_test_data_in[i][j] = 1'b1;
      else tester.tb_test_data_in[i][j] = 1'b0;
    end
// All other bits
  else begin
    if ((data[i][j-1] && data[i][j]) || (!data[i][j-1] && !data[i][j])) tester.tb_test_data_in[i][j] = 1'b1;
    else tester.tb_test_data_in[i][j] = 1'b0;
  end
  end
end
end
endtask

initial begin
testVector test;
integer ind;
static logic [63:0][7:0] test_data = {{8'hc4}, {8'h87}, {8'hff}, {8'hed}, {8'ha2}, {8'hcf}, {8'h78}, {8'h9c},
                              {8'hde}, {8'hff}, {8'ha1}, {8'h01}, {8'h00}, {8'h55}, {8'h5d}, {8'hdd},
                              {8'hee}, {8'h54}, {8'h76}, {8'h8d}, {8'h52}, {8'hff}, {8'hdd}, {8'hae},
                              {8'ha6}, {8'hb4}, {8'h77}, {8'h63}, {8'hd3}, {8'h99}, {8'haa}, {8'h43},
                              {8'h64}, {8'h96}, {8'h69}, {8'h77}, {8'h45}, {8'hf4}, {8'hb5}, {8'hbb},
                              {8'hc6}, {8'h88}, {8'he4}, {8'hee}, {8'hdd}, {8'h80}, {8'h07}, {8'h10},
                              {8'h80}, {8'h73}, {8'hda}, {8'hbe}, {8'hcb}, {8'hff}, {8'h00}, {8'h65},
                              {8'h98}, {8'hfe}, {8'hef}, {8'hcc}, {8'hab}, {8'hbc}, {8'h33}, {8'hf2}};
                              
tb_test_case               = "Initilization";
tb_test_case_num           = -1;

//*****************************************************************************
                        // Power-on-Reset Test Case
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "Power-on-Reset";
tb_test_case_num = tb_test_case_num + 1;

// Reset the DUT
reset_dut();

// Initialize expected values
tb_expected_rx_packet = '0;
tb_expected_rx_packet_data = '0;
tb_expected_rx_transfer_active = '0;
tb_expected_rx_error = '0;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '0;

// Check outputs for reset state
tb_check_tag = "after DUT reset";
check_outputs(tb_check_tag);

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);

//*****************************************************************************
                        // Send payload with PID == OUT + USB ENDPOINT + EOP
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "PID == OUT";
tb_test_case_num = tb_test_case_num + 1;

// Reset the DUT
//testVector test;
reset_dut();


@(negedge tb_clk);

tb_expected_rx_error = '0;
tb_expected_rx_error = '0;

//send_sync(test);
encode_byte_and_send(test.tb_sync_in);
encode_byte_and_send(test.tb_pid_in[5]);

tb_expected_rx_packet = PID_OUT;
tb_expected_rx_packet_data = '1;
tb_expected_rx_transfer_active = 1'b1;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '1;

tb_check_tag = "Just check sync byte";
check_outputs(tb_check_tag);

encode_byte_and_send(USB_ENDPOINT[15:8]);
tb_expected_rx_packet_data = '0;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '0;

// Check outputs for reset state
tb_check_tag = "Just check sync byte";
check_outputs(tb_check_tag);

encode_byte_and_send(USB_ENDPOINT[7:0]);
send_eop();

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);

//*****************************************************************************
                        // Send payload with PID == IN + USB ENDPOINT + EOP
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "PID == IN";
tb_test_case_num = tb_test_case_num + 1;
reset_dut();


@(negedge tb_clk);

tb_expected_rx_error = '0;
tb_expected_rx_error = '0;

//send_sync(test);
encode_byte_and_send(test.tb_sync_in);
encode_byte_and_send(test.tb_pid_in[4]);

tb_expected_rx_packet = PID_IN;
tb_expected_rx_packet_data = '1;
tb_expected_rx_transfer_active = 1'b1;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '1;

tb_check_tag = "Just check sync byte";
check_outputs(tb_check_tag);

encode_byte_and_send(USB_ENDPOINT[15:8]);
tb_expected_rx_packet_data = '0;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '0;

// Check outputs for reset state
tb_check_tag = "Just check sync byte";
check_outputs(tb_check_tag);

encode_byte_and_send(USB_ENDPOINT[7:0]);
send_eop();

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);


//*****************************************************************************
//            Send payload with PID == DATA0 + 1 Byte of Data + EOP
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "PID == DATA0 & 1 Byte + EOP";
tb_test_case_num = tb_test_case_num + 1;
reset_dut();


@(negedge tb_clk);

tb_expected_rx_error = '0;
tb_expected_rx_error = '0;

//send_sync(test);
encode_byte_and_send(test.tb_sync_in);
encode_byte_and_send(test.tb_pid_in[3]); //DATA0

tb_expected_rx_packet = PID_DATA0;
tb_expected_rx_packet_data = '1;
tb_expected_rx_transfer_active = 1'b1;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '1;

tb_check_tag = "check pid + sync";
check_outputs(tb_check_tag);

encode_byte_and_send(test_data[0]);
tb_expected_rx_packet_data = test_data[0];
tb_expected_store_rx_packet_data = 1'b1;
tb_expected_flush ='0;
tb_expected_rx_data_ready = 1'b1;

// Check outputs for reset state
tb_check_tag = "CHECK DATA payload";
check_outputs(tb_check_tag);

encode_byte_and_send(test_data[1]);
send_eop();

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);


//*****************************************************************************
//            Send payload with PID == DATA1 + 2 Byte of Data + EOP
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "PID == DATA1 & 2 Bytes + EOP";
tb_test_case_num = tb_test_case_num + 1;
reset_dut();


@(negedge tb_clk);

tb_expected_rx_error = '0;
tb_expected_rx_error = '0;

//send_sync(test);
encode_byte_and_send(test.tb_sync_in);
encode_byte_and_send(test.tb_pid_in[2]); //DATA1

tb_expected_rx_packet = PID_DATA0;
tb_expected_rx_packet_data = '1;
tb_expected_rx_transfer_active = 1'b1;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '1;

tb_check_tag = "check pid + sync";
check_outputs(tb_check_tag);

encode_byte_and_send(test_data[0]);
tb_expected_rx_packet_data = test_data[0];
tb_expected_store_rx_packet_data = 1'b1;
tb_expected_flush ='0;
tb_expected_rx_data_ready = 1'b1;

// Check outputs for reset state
tb_check_tag = "CHECK DATA payload";
check_outputs(tb_check_tag);

encode_byte_and_send(test_data[1]);
send_eop();

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);

//*****************************************************************************
//            Send payload with PID == DATA1 + 16 Byte of Data + EOP
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "PID == DATA1 & 16 Bytes + EOP";
tb_test_case_num = tb_test_case_num + 1;
reset_dut();


@(negedge tb_clk);

tb_expected_rx_error = '0;
tb_expected_rx_error = '0;

//send_sync(test);
encode_byte_and_send(test.tb_sync_in);
encode_byte_and_send(test.tb_pid_in[2]); //DATA1

tb_expected_rx_packet = PID_DATA0;
tb_expected_rx_packet_data = '1;
tb_expected_rx_transfer_active = 1'b1;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '1;

tb_check_tag = "check pid + sync";
check_outputs(tb_check_tag);

for(ind = 0; ind < 17; ind = ind + 1) begin
  encode_byte_and_send(test_data[ind]);
  tb_expected_rx_packet_data = test_data[ind];
  tb_expected_store_rx_packet_data = 1'b1;
  tb_expected_flush ='0;
  tb_expected_rx_data_ready = 1'b1;
  tb_check_tag = "CHECK DATA payload";
  check_outputs(tb_check_tag);
end

//encode_byte_and_send(test_data[1]);
send_eop();

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);

//*****************************************************************************
//            Send payload with PID == DATA0 + 48 Byte of Data + EOP
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "PID == DATA0 & 48 Bytes + EOP";
tb_test_case_num = tb_test_case_num + 1;
reset_dut();


@(negedge tb_clk);

tb_expected_rx_error = '0;
tb_expected_rx_error = '0;

//send_sync(test);
encode_byte_and_send(test.tb_sync_in);
encode_byte_and_send(test.tb_pid_in[3]); //DATA0

tb_expected_rx_packet = PID_DATA0;
tb_expected_rx_packet_data = '1;
tb_expected_rx_transfer_active = 1'b1;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '1;

tb_check_tag = "check pid + sync";
check_outputs(tb_check_tag);

for(ind = 0; ind < 48; ind = ind + 1) begin
  encode_byte_and_send(test_data[ind]);
  tb_expected_rx_packet_data = test_data[ind];
  tb_expected_store_rx_packet_data = 1'b1;
  tb_expected_rx_data_ready = 1'b1;
  tb_check_tag = "CHECK DATA payload";
  check_outputs(tb_check_tag);
end

encode_byte_and_send(8'h55);
tb_expected_rx_packet_data = 8'h55;
tb_expected_store_rx_packet_data = 1'b0;
tb_expected_rx_data_ready = 1'b0;
tb_check_tag = "CHECK too many bytes being sent!";
check_outputs(tb_check_tag);

send_eop();

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);

//*****************************************************************************
//            Send payload with PID == DATA1 + 65 Byte of Data + EOP
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "PID == DATA1 & 65 Bytes W/ ERROR HIGH + EOP";
tb_test_case_num = tb_test_case_num + 1;
reset_dut();


@(negedge tb_clk);

tb_expected_rx_error = '0;
tb_expected_rx_error = '0;

//send_sync(test);
encode_byte_and_send(test.tb_sync_in);
encode_byte_and_send(test.tb_pid_in[2]); //DATA1

tb_expected_rx_packet = PID_DATA0;
tb_expected_rx_packet_data = '1;
tb_expected_rx_transfer_active = 1'b1;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '1;

tb_check_tag = "check pid + sync";
check_outputs(tb_check_tag);

for(ind = 0; ind < 64; ind = ind + 1) begin
  encode_byte_and_send(test_data[ind]);
  tb_expected_rx_packet_data = test_data[ind];
  tb_expected_store_rx_packet_data = 1'b1;
  tb_expected_rx_data_ready = 1'b1;
  tb_check_tag = "CHECK DATA payload";
  check_outputs(tb_check_tag);
end

encode_byte_and_send(8'h55);
tb_expected_rx_packet_data = 8'h55;
tb_expected_store_rx_packet_data = 1'b0;
tb_expected_rx_data_ready = 1'b0;
tb_check_tag = "CHECK too many bytes being sent!";
check_outputs(tb_check_tag);

send_eop();

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);

//*****************************************************************************
//            Send payload with PID == DATA1 + 1 Byte of Data + Premature EOP
//*****************************************************************************
// Update Navigation Info
tb_test_case     = "PID == DATA1 + 1 Byte of Data + Premature EOP";
tb_test_case_num = tb_test_case_num + 1;
reset_dut();


@(negedge tb_clk);

tb_expected_rx_error = '0;
tb_expected_rx_error = '0;

//send_sync(test);
encode_byte_and_send(test.tb_sync_in);
encode_byte_and_send(test.tb_pid_in[2]); //DATA1

tb_expected_rx_packet = PID_DATA0;
tb_expected_rx_packet_data = '1;
tb_expected_rx_transfer_active = 1'b1;
tb_expected_store_rx_packet_data = '0;
tb_expected_flush ='0;
tb_expected_rx_data_ready = '1;

tb_check_tag = "check pid + sync";
check_outputs(tb_check_tag);

encode_byte_and_send(test_data[0]);
tb_expected_rx_packet_data = test_data[0];
tb_expected_store_rx_packet_data = 1'b1;
tb_expected_rx_data_ready = 1'b1;
tb_check_tag = "CHECK DATA payload";
check_outputs(tb_check_tag);

premature_eop();
tb_expected_rx_packet_data = 8'h00;
tb_expected_store_rx_packet_data = 1'b0;
tb_expected_rx_data_ready = 1'b0;
tb_expected_rx_error = 1'b1;
tb_check_tag = "Premature EOP";
check_outputs(tb_check_tag);

// Give some visual spacing between check and next test case start
#(CLK_PERIOD * 3);
 //Just ensure that we can still read and error goes low when reading another packet
encode_byte_and_send(test.tb_sync_in);
$stop;
end

endmodule