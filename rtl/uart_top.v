// =========================================================
// Module: uart_top
// Wires baud_rate_gen + uart_tx + uart_rx together
// =========================================================

module uart_top #(
    parameter CLK_FREQ = 50_00_000,
    parameter BAUD_RATE = 115200
)(
    input wire clk,
    input wire rst_n,
    // TX interface
    input wire tx_start,
    input wire [7:0] tx_data,
    output wire tx_out,
    output wire tx_busy,
    // RX interface
    input wire rx_in,
    output wire [7:0] rx_data,
    output wire rx_valid
);
    wire tick;
    
    baud_rate_gen #(
        .CLK_FREQ (CLK_FREQ),
        .BAUD_RATE (BAUD_RATE)
    ) u_brg (
        .clk (clk),
        .rst_n (rst_n),
        .tick (tick)
    );

    uart_tx u_tx (
        .clk (clk),
        .rst_n (rst_n),
        .tick (tick),
        .tx_start (tx_start),
        .tx_data (tx_data),
        .tx_out (tx_out),
        .tx_busy (tx_busy)
    );

    uart_rx u_rx (
        .clk (clk),
        .rst_n (rst_n),
        .tick (tick),
        .rx_in (rx_in),
        .rx_data (rx_data),
        .rx_valid (rx_valid)
    );

endmodule

