# UART IP Core (Verilog-2001)

[![Standard](https://img.shields.io/badge/IEEE%20Standard-Verilog--2001-blue.svg)](https://en.wikipedia.org/wiki/Verilog)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Verification](https://img.shields.io/badge/Verification-Self--Checking%20Testbench-brightgreen.svg)](tb/uart_tb.v)
[![Target EDA](https://img.shields.io/badge/EDA-Vivado%20%7C%20Quartus%20%7C%20DC%20%7C%20Icarus-orange.svg)](sim/)

A fully parameterized, production-ready, synthesizable **Universal Asynchronous Receiver/Transmitter (UART)** IP core written in **Verilog-2001**. Designed according to industrial ASIC/FPGA RTL design standards, featuring a 16x oversampling baud rate generator, glitch rejection filter, 2-stage metastability synchronizer, framing error detection, and self-checking testbench.

---

## 📌 Key Architectural Features

- **8N1 Protocol Standard**: 1 Start Bit (LOW), 8 Data Bits (LSB-first), No Parity, 1 Stop Bit (HIGH).
- **Parameterized Baud Rate Generator**: Computes divider dynamically:
  $$\text{DIVISOR} = \frac{\text{CLK\_FREQ}}{\text{BAUD\_RATE} \times 16}$$
- **Counter Auto-Sizing**: Employs `$clog2(DIVISOR)` to minimize gate count and register overhead.
- **16x Oversampling & Glitch Filtering**: Samples incoming serial line at Tick 7 (mid-bit) and validates Start bit integrity to discard false noise spikes.
- **Metastability Protection**: Integrated two-stage D flip-flop synchronizer on asynchronous `rx_in`.
- **Clean FSM Design**: 2-process state machines eliminating inferred latches and race conditions.
- **ASIC/FPGA Tool Compatibility**: Fully synthesizable across Synopsys Design Compiler, Cadence Genus, Vivado, Quartus, Yosys, Icarus Verilog, and VCS.

---

## 📐 System Architecture & Block Diagram

```text
                               +-------------------------------------------------------+
                               |                      UART_TOP                         |
                               |                                                       |
                               |  +-------------------+                                |
                               |  |   BAUD_RATE_GEN   |                                |
  clk --------------------------> |                   |                                |
  rst_n ------------------------> |  DIVISOR =        |                                |
                               |  |  CLK / (BAUD*16)  |                                |
                               |  +---------+---------+                                |
                               |            |                                          |
                               |            | tick (1-cycle pulse)                     |
                               |            +-------------------+                      |
                               |            |                   |                      |
                               |            v                   v                      |
                               |  +-------------------+  +-------------------+         |
  tx_start ---------------------> |      UART_TX      |  |      UART_RX      |         |
  tx_data[7:0] -----------------> |                   |  |                   | <------ rx_in
                               |  |  States: IDLE,    |  |  Sync Stage (2FF) |         |
  tx_busy <---------------------- |          START,   |  |  States: IDLE,    | -------> rx_data[7:0]
  tx_done <---------------------- |          DATA,    |  |          START,   | -------> rx_valid
  tx_out <----------------------- |          STOP     |  |          STOP     | -------> rx_frame_err
                               |  +-------------------+  |          STOP     |         |
                               |                         +-------------------+         |
                               +-------------------------------------------------------+
```

---

## 📂 Repository Directory Structure

```text
UART_Project/
├── rtl/
│   ├── baud_rate_gen.v    # Parameterized 16x baud rate clock divider
│   ├── uart_tx.v          # UART Transmitter FSM (8N1, LSB first)
│   ├── uart_rx.v          # UART Receiver FSM (16x oversampling & glitch rejection)
│   └── uart_top.v         # Top-level wrapper integrating Baud Gen, TX, and RX
├── tb/
│   └── uart_tb.v          # Self-checking testbench with loopback & randomized stimulus
├── sim/
│   ├── Makefile           # iverilog build & test execution targets
│   ├── run_iverilog.sh    # Bash script for Icarus Verilog + GTKWave workflow
│   └── run_vcs.sh         # Bash script for Synopsys VCS compilation
├── docs/
│   ├── Architecture.md    # High-level architecture & module specifications
│   ├── FSM.md             # FSM state transition diagrams and mechanics
│   ├── Timing.md          # 16x oversampling equations & baud rate error math
│   ├── Waveforms.md       # GTKWave verification walkthrough & signal guide
│   ├── Synthesis.md       # SDC timing constraints, STA, & power optimization
│   └── Interview_Questions.md # Senior ASIC interview preparation deep-dives
├── README.md              # Project documentation & GitHub guide
└── LICENSE                # MIT License
```

---

## 🚀 Simulation & Build Instructions

### Prerequisites
- **Icarus Verilog** (`iverilog`), `vvp`, and **GTKWave** (or Synopsys VCS / ModelSim).

### Quickstart with Makefile
Navigate to the `sim/` directory:

```bash
cd sim

# Compile and run simulation
make all

# Launch waveform in GTKWave
make wave

# Clean build artifacts
make clean
```

### Running with Icarus Verilog Script
```bash
cd sim
chmod +x run_iverilog.sh
./run_iverilog.sh
```

### Running with Synopsys VCS
```bash
cd sim
chmod +x run_vcs.sh
./run_vcs.sh
```

---

## 📊 Expected Simulation Output

Upon executing the self-checking testbench, the console output will display regression progress and summary metrics:

```text
=========================================================
 STARTING PRODUCTION UART IP VERIFICATION REGRESSION
=========================================================

--- [TEST 1] RESET VERIFICATION ---
[TB] Reset sequence completed successfully.
[TEST 1] [PASS] Default reset state signals verified.

--- [TEST 2] DETERMINISTIC PATTERN LOOPBACK ---
[TB] Initiated TX transfer: 0x55
[SCOREBOARD] [PASS] Match at Index 0! Expected: 0x55, Received: 0x55
[TB] Initiated TX transfer: 0xA5
[SCOREBOARD] [PASS] Match at Index 1! Expected: 0xA5, Received: 0xA5
[TB] Initiated TX transfer: 0x00
[SCOREBOARD] [PASS] Match at Index 2! Expected: 0x00, Received: 0x00
[TB] Initiated TX transfer: 0xFF
[SCOREBOARD] [PASS] Match at Index 3! Expected: 0xFF, Received: 0xFF

--- [TEST 3] BACK-TO-BACK TRANSFERS ---
...
--- [TEST 4] RANDOMIZED DATA REGRESSION (20 PACKETS) ---
...
--- [TEST 5] NOISE GLITCH REJECTION CHECK ---
[TB] Injecting noise glitch (false start bit) on RX line...
[TEST 5] [PASS] Noise glitch successfully filtered and rejected.

--- [TEST 6] FRAMING ERROR DETECTION ---
[TB] Caught expected framing error pulse!
[TEST 6] [PASS] Framing error flag correctly asserted.

--- [TEST 7] TX BUSY GUARD CHECK ---
[TB] Asserted illegal tx_start while TX was busy.
[TEST 7] [PASS] Illegal tx_start correctly ignored.

=========================================================
            FINAL REGRESSION TEST RESULTS
=========================================================
 Total Pass Checks : 35
 Total Fail Checks : 0
 STATUS             : >>> REGRESSION PASSED <<<
=========================================================
```

---

## 📖 Deep-Dive Documentation Index

For detailed architectural and verification engineering specifications, refer to the `docs/` directory:
- 📄 [Architecture Specification](docs/Architecture.md)
- 📄 [FSM Design Mechanics](docs/FSM.md)
- 📄 [Timing & Baud Mathematics](docs/Timing.md)
- 📄 [Waveform Verification Walkthrough](docs/Waveforms.md)
- 📄 [Synthesis & SDC Constraints](docs/Synthesis.md)
- 📄 [Senior ASIC Interview Q&A](docs/Interview_Questions.md)

---

## 📜 License

This IP core is released under the [MIT License](LICENSE).
