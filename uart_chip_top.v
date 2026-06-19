`timescale 1ns/1ps
//==================================================================
// uart_chip_top
//   Chip-level wrapper that instantiates I/O pads around uart_top.
//==================================================================
module uart_chip_top (
    // Chip-level pins
    inout wire        clk_pad,
    inout wire        rst_n_pad,
    inout wire [15:0] baud_div_pad,
    inout wire [15:0] oversample_div_pad,
    inout wire [7:0]  tx_data_pad,
    inout wire        tx_valid_pad,
    inout wire        tx_busy_pad,
    inout wire [7:0]  rx_data_pad,
    inout wire        rx_valid_pad,
    inout wire        frame_error_pad,

    // Power / Ground pins
    inout wire        VDD,
    inout wire        VSS
);

    //----------------------------------
    // Core-side signals (connect to uart_top)
    //----------------------------------
    wire        clk;
    wire        rst_n;
    wire [15:0] baud_div;
    wire [15:0] oversample_div;
    wire [7:0]  tx_data;
    wire        tx_valid;
    wire        tx_busy;
    wire [7:0]  rx_data;
    wire        rx_valid;
    wire        frame_error;

    //----------------------------------
    // Input Pads (PADI pins: PAD, OUT)
    //----------------------------------
    PADI u_pad_clk        (.PAD(clk_pad),      .OUT(clk));
    PADI u_pad_rst_n      (.PAD(rst_n_pad),    .OUT(rst_n));
    PADI u_pad_tx_valid   (.PAD(tx_valid_pad), .OUT(tx_valid));

    //----------------------------------
    // Bidirectional Pads (PADIO pins: PAD, OEN, IN, OUT)
    // Using instance arrays to match .io naming format [X]
    //----------------------------------
    PADIO u_pad_baud_div [15:0] (
        .PAD (baud_div_pad),
        .OUT (baud_div),
        .IN  (16'b0),
        .OEN (16'hFFFF)       // 1 = hi-Z (input only)
    );

    PADIO u_pad_oversample_div [15:0] (
        .PAD (oversample_div_pad),
        .OUT (oversample_div),
        .IN  (16'b0),
        .OEN (16'hFFFF)       // 1 = hi-Z (input only)
    );

    PADIO u_pad_tx_data [7:0] (
        .PAD (tx_data_pad),
        .OUT (tx_data),
        .IN  (8'b0),
        .OEN (8'hFF)          // 1 = hi-Z (input only)
    );

    //----------------------------------
    // Output Pads (PADO pins: PAD, IN)
    //----------------------------------
    PADO u_pad_tx_busy     (.PAD(tx_busy_pad),     .IN(tx_busy));
    PADO u_pad_rx_valid    (.PAD(rx_valid_pad),    .IN(rx_valid));
    PADO u_pad_frame_error (.PAD(frame_error_pad), .IN(frame_error));

    PADO u_pad_rx_data [7:0] (
        .PAD (rx_data_pad),
        .IN  (rx_data)
    );

    //----------------------------------
    // Power / Ground Pads (matching .io distribution exactly)
    //----------------------------------
    PADVDD1 u_pad_vdd0 (.VDD(VDD));
    PADVDD1 u_pad_vdd1 (.VDD(VDD));
    PADVDD1 u_pad_vdd2 (.VDD(VDD));
    PADVDD1 u_pad_vdd3 (.VDD(VDD));
    PADVDD1 u_pad_vdd4 (.VDD(VDD));

    PADVSS1 u_pad_vss0 (.VSS(VSS));
    PADVSS1 u_pad_vss1 (.VSS(VSS));
    PADVSS1 u_pad_vss2 (.VSS(VSS));
    PADVSS1 u_pad_vss3 (.VSS(VSS));
    PADVSS1 u_pad_vss4 (.VSS(VSS));
    PADVSS1 u_pad_vss5 (.VSS(VSS));

    //----------------------------------
    // Corner Pads for continuous pad ring routing
    //----------------------------------
    PADCORNER u_pad_corner_bl ();
    PADCORNER u_pad_corner_br ();
    PADCORNER u_pad_corner_tl ();
    PADCORNER u_pad_corner_tr ();

    //----------------------------------
    // Core Logic
    //----------------------------------
    uart_top u_uart_top (
        .clk            (clk),
        .rst_n          (rst_n),
        .baud_div       (baud_div),
        .oversample_div (oversample_div),
        .tx_data        (tx_data),
        .tx_valid       (tx_valid),
        .tx_busy        (tx_busy),
        .rx_data        (rx_data),
        .rx_valid       (rx_valid),
        .frame_error    (frame_error)
    );

endmodule
