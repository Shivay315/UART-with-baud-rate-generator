# =================================================================
# uart_chip_top.io
# I/O Pad Ring Definition File
#
# Format:
#   <pad_instance_name>  <pad_cell>  <chip_pin>  <core_signal>  <side>
#
# side : T = Top, R = Right, B = Bottom, L = Left
# Pads are listed in placement order, starting at the bottom-left
# corner and proceeding counter-clockwise around the ring.
# Power/ground pads are distributed for IR-drop / ESD robustness;
# adjust spacing/count to your floorplan and current budget.
# =================================================================

# ---------------- Bottom side ----------------
u_pad_vss0          PADVSS1   VSS                 -                    B
u_pad_clk           PADI      clk_pad             clk                  B
u_pad_rst_n         PADI      rst_n_pad           rst_n                B
u_pad_vdd0          PADVDD1   VDD                 -                    B
u_pad_tx_valid      PADI      tx_valid_pad        tx_valid             B
u_pad_tx_busy       PADO      tx_busy_pad         tx_busy              B
u_pad_vss1          PADVSS1   VSS                 -                    B

# ---------------- Right side -----------------
u_pad_tx_data[0]     PADIO    tx_data_pad[0]      tx_data[0]           R
u_pad_tx_data[1]     PADIO    tx_data_pad[1]      tx_data[1]           R
u_pad_tx_data[2]     PADIO    tx_data_pad[2]      tx_data[2]           R
u_pad_tx_data[3]     PADIO    tx_data_pad[3]      tx_data[3]           R
u_pad_vdd1           PADVDD1  VDD                 -                    R
u_pad_tx_data[4]     PADIO    tx_data_pad[4]      tx_data[4]           R
u_pad_tx_data[5]     PADIO    tx_data_pad[5]      tx_data[5]           R
u_pad_tx_data[6]     PADIO    tx_data_pad[6]      tx_data[6]           R
u_pad_tx_data[7]     PADIO    tx_data_pad[7]      tx_data[7]           R
u_pad_vss2           PADVSS1  VSS                 -                    R

# ---------------- Top side -------------------
u_pad_rx_data[0]     PADO     rx_data_pad[0]      rx_data[0]           T
u_pad_rx_data[1]     PADO     rx_data_pad[1]      rx_data[1]           T
u_pad_rx_data[2]     PADO     rx_data_pad[2]      rx_data[2]           T
u_pad_rx_data[3]     PADO     rx_data_pad[3]      rx_data[3]           T
u_pad_vdd2           PADVDD1  VDD                 -                    T
u_pad_rx_data[4]     PADO     rx_data_pad[4]      rx_data[4]           T
u_pad_rx_data[5]     PADO     rx_data_pad[5]      rx_data[5]           T
u_pad_rx_data[6]     PADO     rx_data_pad[6]      rx_data[6]           T
u_pad_rx_data[7]     PADO     rx_data_pad[7]      rx_data[7]           T
u_pad_rx_valid       PADO     rx_valid_pad        rx_valid             T
u_pad_frame_error    PADO     frame_error_pad     frame_error          T
u_pad_vss3           PADVSS1  VSS                 -                    T

# ---------------- Left side -------------------
u_pad_baud_div[0]    PADIO    baud_div_pad[0]     baud_div[0]          L
u_pad_baud_div[1]    PADIO    baud_div_pad[1]     baud_div[1]          L
u_pad_baud_div[2]    PADIO    baud_div_pad[2]     baud_div[2]          L
u_pad_baud_div[3]    PADIO    baud_div_pad[3]     baud_div[3]          L
u_pad_baud_div[4]    PADIO    baud_div_pad[4]     baud_div[4]          L
u_pad_baud_div[5]    PADIO    baud_div_pad[5]     baud_div[5]          L
u_pad_baud_div[6]    PADIO    baud_div_pad[6]     baud_div[6]          L
u_pad_baud_div[7]    PADIO    baud_div_pad[7]     baud_div[7]          L
u_pad_vdd3           PADVDD1  VDD                 -                    L
u_pad_baud_div[8]    PADIO    baud_div_pad[8]     baud_div[8]          L
u_pad_baud_div[9]    PADIO    baud_div_pad[9]     baud_div[9]          L
u_pad_baud_div[10]   PADIO    baud_div_pad[10]    baud_div[10]         L
u_pad_baud_div[11]   PADIO    baud_div_pad[11]    baud_div[11]         L
u_pad_baud_div[12]   PADIO    baud_div_pad[12]    baud_div[12]         L
u_pad_baud_div[13]   PADIO    baud_div_pad[13]    baud_div[13]         L
u_pad_baud_div[14]   PADIO    baud_div_pad[14]    baud_div[14]         L
u_pad_baud_div[15]   PADIO    baud_div_pad[15]    baud_div[15]         L
u_pad_vss4           PADVSS1  VSS                 -                    L

# ---------------- Remaining bottom (wraps back) ----------------
u_pad_oversample[0]  PADIO    oversample_div_pad[0]  oversample_div[0]  B
u_pad_oversample[1]  PADIO    oversample_div_pad[1]  oversample_div[1]  B
u_pad_oversample[2]  PADIO    oversample_div_pad[2]  oversample_div[2]  B
u_pad_oversample[3]  PADIO    oversample_div_pad[3]  oversample_div[3]  B
u_pad_oversample[4]  PADIO    oversample_div_pad[4]  oversample_div[4]  B
u_pad_oversample[5]  PADIO    oversample_div_pad[5]  oversample_div[5]  B
u_pad_oversample[6]  PADIO    oversample_div_pad[6]  oversample_div[6]  B
u_pad_oversample[7]  PADIO    oversample_div_pad[7]  oversample_div[7]  B
u_pad_vdd4           PADVDD1  VDD                 -                    B
u_pad_oversample[8]  PADIO    oversample_div_pad[8]  oversample_div[8]  B
u_pad_oversample[9]  PADIO    oversample_div_pad[9]  oversample_div[9]  B
u_pad_oversample[10] PADIO    oversample_div_pad[10] oversample_div[10] B
u_pad_oversample[11] PADIO    oversample_div_pad[11] oversample_div[11] B
u_pad_oversample[12] PADIO    oversample_div_pad[12] oversample_div[12] B
u_pad_oversample[13] PADIO    oversample_div_pad[13] oversample_div[13] B
u_pad_oversample[14] PADIO    oversample_div_pad[14] oversample_div[14] B
u_pad_oversample[15] PADIO    oversample_div_pad[15] oversample_div[15] B
u_pad_vss5           PADVSS1  VSS                 -                    B

# =================================================================
# Pad count summary
#   PADI    : 2   (clk, rst_n)            -- plus tx_valid = 3 total
#   PADO    : 11  (tx_busy, rx_valid, frame_error, rx_data[7:0])
#   PADIO   : 40  (tx_data[7:0], baud_div[15:0], oversample_div[15:0])
#   PADVDD1 : 5
#   PADVSS1 : 6
#   ---------------------------------------------------------------
#   TOTAL   : 65 pads
# =================================================================
