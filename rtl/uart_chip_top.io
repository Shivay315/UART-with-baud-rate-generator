(globals
	version = 3
	io_order = clockwise
)

(iopad
	(top
		(inst name="g_rx_data_pad[0].u_pad_rx_data" cell="pc3o02" place_status=fixed)
		(inst name="g_rx_data_pad[1].u_pad_rx_data" cell="pc3o02" place_status=fixed)
		(inst name="g_rx_data_pad[2].u_pad_rx_data" cell="pc3o02" place_status=fixed)
		(inst name="g_rx_data_pad[3].u_pad_rx_data" cell="pc3o02" place_status=fixed)
		(inst name="u_pad_vdd3" cell="pvdc" place_status=fixed)
		(inst name="g_rx_data_pad[4].u_pad_rx_data" cell="pc3o02" place_status=fixed)
		(inst name="g_rx_data_pad[5].u_pad_rx_data" cell="pc3o02" place_status=fixed)
		(inst name="g_rx_data_pad[6].u_pad_rx_data" cell="pc3o02" place_status=fixed)
		(inst name="g_rx_data_pad[7].u_pad_rx_data" cell="pc3o02" place_status=fixed)
		(inst name="u_pad_vss5" cell="pv0c" place_status=fixed)
		(inst name="g_tx_data_pad[0].u_pad_tx_data" cell="pc3b02" place_status=fixed)
		(inst name="g_tx_data_pad[1].u_pad_tx_data" cell="pc3b02" place_status=fixed)
		(inst name="g_tx_data_pad[2].u_pad_tx_data" cell="pc3b02" place_status=fixed)
		(inst name="g_tx_data_pad[3].u_pad_tx_data" cell="pc3b02" place_status=fixed)
		(inst name="u_pad_vdd2" cell="pvdc" place_status=fixed)
		(inst name="g_tx_data_pad[4].u_pad_tx_data" cell="pc3b02" place_status=fixed)
		(inst name="g_tx_data_pad[5].u_pad_tx_data" cell="pc3b02" place_status=fixed)
		(inst name="g_tx_data_pad[6].u_pad_tx_data" cell="pc3b02" place_status=fixed)
		(inst name="g_tx_data_pad[7].u_pad_tx_data" cell="pc3b02" place_status=fixed)
		(inst name="u_pad_vss3" cell="pv0c" place_status=fixed)
	)
	
	(right
		(inst name="g_oversample_div_pad[0].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[1].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[2].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[3].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[4].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[5].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[6].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[7].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="u_pad_vdd1" cell="pvdc" place_status=fixed)
		(inst name="g_oversample_div_pad[8].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[9].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[10].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[11].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[12].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[13].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[14].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="g_oversample_div_pad[15].u_pad_oversample" cell="pc3b02" place_status=fixed)
		(inst name="u_pad_vss2" cell="pv0c" place_status=fixed)
	)

	(bottom
		(inst name="u_pad_vss0" cell="pv0c" place_status=fixed)
		(inst name="u_pad_clk" cell="pc3d21" place_status=fixed)
		(inst name="u_pad_rst_n" cell="pc3d21" place_status=fixed)
		(inst name="u_pad_vdd0" cell="pvdc" place_status=fixed)
		(inst name="u_pad_tx_valid" cell="pc3d21" place_status=fixed)
		(inst name="u_pad_tx_busy" cell="pc3o02" place_status=fixed)
		(inst name="u_pad_rx_valid" cell="pc3o02" place_status=fixed)
		(inst name="u_pad_frame_error" cell="pc3o02" place_status=fixed)
		(inst name="u_pad_vss1" cell="pv0c" place_status=fixed)
	)


	(left
		(inst name="g_baud_div_pad[0].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[1].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[2].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[3].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[4].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[5].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[6].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[7].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="u_pad_vdd4" cell="pvdc" place_status=fixed)
		(inst name="g_baud_div_pad[8].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[9].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[10].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[11].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[12].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[13].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[14].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="g_baud_div_pad[15].u_pad_baud_div" cell="pc3b02" place_status=fixed)
		(inst name="u_pad_vss4" cell="pv0c" place_status=fixed)
	)
)

# =================================================================
# Pad count summary
#   pc3d21    : 3   (clk, rst_n, tx_valid)
#   pc3o02    : 11  (tx_busy, rx_valid, frame_error, rx_data[7:0])
#   pc3b02   : 40  (tx_data[7:0], baud_div[15:0], oversample_div[15:0])
#   pvdc : 5
#   pv0c : 6
#   ---------------------------------------------------------------
#   TOTAL   : 65 pads
# =================================================================
