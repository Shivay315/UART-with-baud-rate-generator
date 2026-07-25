// ===================================================================
// Module: uart_rx
// Purpose: Deserialize incoming UART stream (8N1)
// ===================================================================

module uart_rx (
    input wire          clk,
    input wire          rst_n,
    input wire          tick,       // 16x baud tick from baud_rate_gen
    input wire          rx_in,      // serial line (idle = 1)
    output reg [7:0]    rx_data,    // byte received
    output reg          rx_ready    // pulse high for 1 cycle when new data is ready
);

    localparam IDLE = 2'd0;
    localparam START = 2'd1;
    localparam DATA = 2'd2;
    localparam STOP = 2'd3;

    reg [1:0] state;
    reg [3:0] tick_cnt;  // counts 0..15 (16 ticks = 1 bit period)  
    reg [2:0] bit_idx;   // which data bit we're receiving (0..7)
    reg [7:0] shift_reg; // holds the byte being shifted in

    // ---- falling-edge detector (detects start bit) ----
    reg rx_prev;
    wire start_detected = rx_prev & ~rx_in; // high->low transition

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            rx_prev <= 1;
        else
            rx_prev <= rx_in;
    end
    // ------------------------------------------------------

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            tick_cnt <= 0;
            bit_idx <= 0;
            shift_reg <= 0;
            rx_data <= 0;
            rx_valid <= 0;
        end
        else begin
            rx_valid <= 0; // default: pulse only for 1 cycle

            case (state) 

                IDLE: begin
                    if (start_detected) begin
                        // A falling edge seen = possible start bit
                        tick_cnt <= 0;
                        state <= START;
                    end
                end

                START: begin
                    // Wait 8 ticks to sample in the MIDDLE of start bit
                    // This is the key 16x oversampling trick
                    if (tick) begin
                        if (tick_cnt == 7) begin
                            if (rx_in == 0) begin
                                // Confirmed start bit, not a glitch
                                tick_cnt <= 0;
                                bit_idx <= 0;;
                                state <= DATA;
                            end
                            else begin
                                // Line went high again - was a glitch, abort
                                state <= IDLE;
                            end
                        end
                        else begin
                            tick_cnt <= tick_cnt + 1;
                        end
                    end
                end

                DATA: begin
                    // Sample each data bit at its center (every 16 ticks)
                    if (tick) begin
                        if (tick_cnt == 15) begin
                            // Sample and shift in (LSB first, so shift into MSB end)
                            shift_reg <= {rx_in, shift_reg[7:1]};
                            tick_cnt <= 0;
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
                    if (tick) begin
                        if (tick_cnt == 15) begin
                            if (rx_in == 1) begin
                                // Valid stop bit
                                rx_data <= shift_reg;
                                rx_valid <= 1; // pulse high for 1 cycle
                            end
                            // If rx_in==0 here, it's a framing error
                            // (ignored for simplicity, could add error flag)
                            state <= IDLE;
                            tick_cnt <= 0;
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
