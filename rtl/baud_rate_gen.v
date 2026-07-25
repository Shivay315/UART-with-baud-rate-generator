// ====================================================
// Module: baud_rate_gen
// Purpose: Divide system clock down to 16 baud tick
// ====================================================

module baud_rate_gen #(
    parameter CLK_FREQ = 50_00_000,
    parameter BAUD_RATE = 115200
)(
    input wire clk,
    input wire rst_n,
    output reg tick     // 1-cycle pulse at 16 x BAUD_RATE
);

    // How many sys-clock cycles fit in one 16x-baud period
localparam DIVISOR = CLK_FREQ / (BAUD_RATE * 16);   // = 27

// Counter needs enough bits to hold DIVISOR-1
// $clog2(27) = 5 bits
reg [$clog2(DIVISOR)-1 : 0] count;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 0;
        tick <= 0;
    end
    else begin
        if (count == DIVISOR - 1) begin
            count <= 0;
            tick <= 1;
        end
        else begin
            count <= count + 1;
            tick <= 0;
        end
    end
end

endmodule
