// ==============================================================
// Module: uart_tx
// Purpose: Serialize 8-bit data over UART (8N1 format)
// ==============================================================

module uart_tx (
    input wire          clk,
    input wire          rst_n,
    input wire          tick,       // 16x baud tick from baud_rate_gen
    input wire          tx_start,   // pulse high for 1 cycle to begin TX
    input wire [7:0]    tx_data,    // byte to transmit
    output reg          tx_out,     // serial line (idle = 1)
    output reg          tx_busy     // high while transmitting
);

    // FSM state encoding
    localparam IDLE = 2'd0;
    localparam START = 2'd1;
    localparam DATA = 2'd2;
    localparam STOP = 2'd3;

    reg [1:0] state;
    reg [3:0] tick_cnt;  // counts 0..15 (16 ticks = 1 bit period)
    reg [2:0] bit_idx;   // which data bit we're sending (0..7)
    reg [7:0] shift_reg; // holds the byte being shifted out

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            tx_out <= 1;
            tx_busy <= 0;
            tick_cnt <= 0;
            bit_idx <= 0;
            shift_reg <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    tx_out <= 1;
                    tx_busy <= 0;
                    if (tx_start) begin
                        shift_reg <= tx_data;       // latch data now
                        tick_cnt <= 0;
                        state <= START;
                        tx_busy <= 1;
                    end
                end
                START: begin
                    tx_out <= 0; // start bit = 0
                    if (tick) begin
                        if (tick_cnt == 15) begin
                            // one full bit-period elapsed
                            tick_cnt <= 0;
                            bit_idx <= 0;
                            state <= DATA;
                        end
                        else begin
                            tick_cnt <= tick_cnt + 1;
                        end
                    end
                end
                DATA: begin
                    tx_out <= shift_reg[0]; // LSB first
                    if (tick) begin
                        if (tick_cnt == 15) begin
                            tick_cnt <= 0;
                            shift_reg <= shift_reg >> 1; // shift right
                            if (bit_idx == 7) begin
                                state <= STOP;
                            end
                            else begin
                                bit_idx <= bit_idx + 1;
                            end
                        end
                        else begin
                            tick_cnt <= tick_cnt + 1;
                        end
                    end
                end
                STOP: begin
                    tx_out <= 1; // stop bit = 1
                    if (tick) begin
                        if (tick_cnt == 15) begin
                            tick_cnt <= 0;
                            state <= IDLE;
                            tx_busy <= 0;
                        end
                        else begin
                            tick_cnt <= tick_cnt + 1;
                        end
                    end
                end
            endcase
        end
    end
endmodule
