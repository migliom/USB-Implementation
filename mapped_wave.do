onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Test Bench}
add wave -noupdate -color Gold /tb_usb_endpoint/tb_test_case_num
add wave -noupdate -color Gold /tb_usb_endpoint/tb_test_case
add wave -noupdate /tb_usb_endpoint/tb_clk
add wave -noupdate /tb_usb_endpoint/tb_n_rst
add wave -noupdate -color Salmon -radix unsigned /tb_usb_endpoint/DUT/TX_USB/buffer_occupancy
add wave -noupdate -divider {TX Module Signals}
add wave -noupdate -color Cyan /tb_usb_endpoint/tb_dplus_out
add wave -noupdate -color Cyan /tb_usb_endpoint/tb_dminus_out
add wave -noupdate /tb_usb_endpoint/tb_expected_dplus_out
add wave -noupdate /tb_usb_endpoint/tb_expected_dminus_out
add wave -noupdate /tb_usb_endpoint/DUT/TX_USB/tx_error
add wave -noupdate -radix unsigned /tb_usb_endpoint/DUT/TX_USB/tx_packet_data
add wave -noupdate /tb_usb_endpoint/DUT/TX_USB/tx_packet
add wave -noupdate -divider AHB-Lite
add wave -noupdate -color Magenta /tb_usb_endpoint/tb_hsel
add wave -noupdate -color Magenta /tb_usb_endpoint/tb_htrans
add wave -noupdate -color Magenta -radix hexadecimal /tb_usb_endpoint/tb_haddr
add wave -noupdate -color Magenta -radix binary /tb_usb_endpoint/tb_hsize
add wave -noupdate -color Magenta /tb_usb_endpoint/tb_hwrite
add wave -noupdate -color Magenta -radix hexadecimal /tb_usb_endpoint/tb_hwdata
add wave -noupdate -color Magenta -radix hexadecimal /tb_usb_endpoint/tb_hrdata
add wave -noupdate -color Magenta /tb_usb_endpoint/tb_hresp
add wave -noupdate -color Magenta /tb_usb_endpoint/DUT/SLAVE/hready
add wave -noupdate -divider {TB Signals}
add wave -noupdate -color Gold /tb_usb_endpoint/tb_test_case
add wave -noupdate -color Gold /tb_usb_endpoint/tb_test_case_num
add wave -noupdate /tb_usb_endpoint/tb_clk
add wave -noupdate /tb_usb_endpoint/tb_n_rst
add wave -noupdate -divider {RX Module Signals}
add wave -noupdate -color Cyan /tb_usb_endpoint/DUT/RX_USB/dplus_sync
add wave -noupdate -color Cyan /tb_usb_endpoint/DUT/RX_USB/dminus_sync
add wave -noupdate -radix hexadecimal /tb_usb_endpoint/expected_rx_data_c
add wave -noupdate /tb_usb_endpoint/DUT/RX_USB/rx_error
add wave -noupdate -radix hexadecimal /tb_usb_endpoint/DUT/RX_USB/rx_packet_data
add wave -noupdate -radix binary /tb_usb_endpoint/DUT/RX_USB/rx_packet
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {47672238 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {237205500 ps}
