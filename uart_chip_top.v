`timescale 1ns/1ps
//==================================================================
// uart_chip_top
//   Chip-level wrapper that instantiates I/O pads around uart_top.
//   Pad cells used: PADI (input), PADO (output), PADIO (bidir),
//                    PADVDD1 (power), PADVSS1 (ground)
//
//   PADI  ports : PAD (pin) , C   (core-side output)
//   PADO  ports : PAD (pin) , I   (core-side input)
//   PADIO ports : PAD (pin) , C   (core-side output / input from pin)
//                  I   (core-side input / output to pin)
//                  OEN (output enable, ACTIVE LOW: 0 = drive, 1 = hi-Z)
//
//   NOTE: OEN polarity assumed active-low (most common convention).
//         If your pad library uses active-high OE, invert the OEN
//         connections below (tie to 1'b0 instead of 1'b1, etc).
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
    // Input Pads
    //----------------------------------
    pc3d21 u_pad_clk (
        .PAD (clk_pad),
        .CIN (clk)
    );

    pc3d21 u_pad_rst_n (
        .PAD (rst_n_pad),
        .CIN (rst_n)
    );

    pc3d21 u_pad_tx_valid (
        .PAD (tx_valid_pad),
        .CIN (tx_valid)
    );

    //----------------------------------
    // Bidirectional Pads - baud_div[15:0]
    //----------------------------------
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : g_baud_div_pad
            pc3b02 u_pad_baud_div (
                .PAD (baud_div_pad[i]),
                .CIN (baud_div[i]),
                .I   (1'b0),
                .OEN (1'b1)          // 1 = hi-Z (input only)
            );
        end
    endgenerate

    //----------------------------------
    // Bidirectional Pads - oversample_div[15:0]
    //----------------------------------
    generate
        for (i = 0; i < 16; i = i + 1) begin : g_oversample_div_pad
            pc3b02 u_pad_oversample_div (
                .PAD (oversample_div_pad[i]),
                .CIN (oversample_div[i]),
                .I   (1'b0),
                .OEN (1'b1)          // 1 = hi-Z (input only)
            );
        end
    endgenerate

    //----------------------------------
    // Bidirectional Pads - tx_data[7:0]
    //----------------------------------
    generate
        for (i = 0; i < 8; i = i + 1) begin : g_tx_data_pad
            pc3b02 u_pad_tx_data (
                .PAD (tx_data_pad[i]),
                .CIN (tx_data[i]),
                .I   (1'b0),
                .OEN (1'b1)          // 1 = hi-Z (input only)
            );
        end
    endgenerate

    //----------------------------------
    // Output Pads
    //----------------------------------
    pc3o02 u_pad_tx_busy (
        .PAD (tx_busy_pad),
        .I   (tx_busy)
    );

    pc3o02 u_pad_rx_valid (
        .PAD (rx_valid_pad),
        .I   (rx_valid)
    );

    pc3o02 u_pad_frame_error (
        .PAD (frame_error_pad),
        .I   (frame_error)
    );

    //----------------------------------
    // Output Pads - rx_data[7:0]
    //----------------------------------
    generate
        for (i = 0; i < 8; i = i + 1) begin : g_rx_data_pad
            pc3o02 u_pad_rx_data (
                .PAD (rx_data_pad[i]),
                .I   (rx_data[i])
            );
        end
    endgenerate

    //----------------------------------
    // Power / Ground Pads
    //----------------------------------
    pvdc u_pad_vdd (
        .VDD (VDD)
    );

    pv0c u_pad_vss (
        .VSS (VSS)
    );

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
