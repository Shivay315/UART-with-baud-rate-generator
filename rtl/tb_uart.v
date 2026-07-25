// ================================================================
// Testbench: tb_uart
// Connects TX output directly to RX input (loopbach test)
// Sends 0xA5 and checks we receive 0xA5 back
// ================================================================

`timescale 1ns/1ps

module tb_uart;

    // Parameters (small values speed up simulation)
    localparam CLK_FREQ = 50_00_000;
    localparam BAUD_RATE = 115200;
    localparam CLK_PERIOD = 20; // 50MHZ -> 20ns period

    // DUT signals
    reg clk, rst_n;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx_out, tx_busy;
    wire [7:0] rx_data;
    wire rx_valid;

    // Instantiate top-level (loopback: tx_out -> rx_in)
    uart_top #(
        .CLK_FREQ (CLK_FREQ),
        .BAUD_RATE (BAUD_RATE)
    ) dut (
        .clk (clk),
        .rst_n (rst_n),
        .tx_start (tx_start),
        .tx_data (tx_data),
        .tx_out (tx_out),
        .tx_busy (tx_busy),
        .rx_in (tx_out),      // loopback connection
        .rx_data (rx_data),
        .rx_valid (rx_valid)
    );

    // Clock generation
    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Test stimulus
    initial begin
        // Setup waveform dump
        $dumpfile("uart.vcd");
        $dumpvars(0, tb_uart);

        // Apply reset
        rst_n = 0;
        tx_start = 0;
        tx_data = 0;
        repeat(10) @(posedge clk);
        rst_n = 1;
        repeat(5) @(posedge clk);

        // Send 0xA5 (1010_0101)
        tx_data = 8'hA5;
        tx_start = 1;
        @(posedge clk);
        tx_start = 0;   // must be a 1-cycle pulse

        // Wait for tx_busy to go low (TX done)
        wait(!tx_busy);

        // Wait for rx_valid
        @(posedge rx_valid);
        @(posedge clk);     // let rx_data settle

        // Check
        if (rx_data == 8'hA5)
            $display("PASS: received 0x%02X", rx_data);
        else
            $display("FAIL: expected 0xA5, got 0x%02X", rx_data);

        // Send a second byte: 0x3C
        @(posedge clk);
        tx_data = 8'h3C;
        tx_start = 1;
        @(posedge clk);
        tx_start = 0;

        wait(!tx_busy);
        @(posedge rx_valid);
        @(posedge clk);

        if (rx_data == 8'h3C)
            $display("PASS: received 0x%02X", rx_data);
        else
            $display("FAIL: expected 0x3C, got 0x%02X", rx_data);

        $display("Simulation complete.");
        $finish;
    end

    // Timeout watchdog (prevents infinite hang)
    initial begin
        #50_00_000; // 50ms timeout
        $display("TIMEOUT - simulation hung.");
        $finish;
    end

endmodule
