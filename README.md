[README (1).md](https://github.com/user-attachments/files/33317569/README.1.md)
# 8-Bit General-Purpose Processor (ALU) in VHDL

An 8-bit Arithmetic Logic Unit (ALU) and its supporting datapath, designed in VHDL and built as a schematic-based top-level design in Quartus II for an Altera/Intel FPGA. A finite state machine steps the ALU through nine operations, and the result is shown on 7-segment displays in hexadecimal.

**Course:** Digital Systems, Toronto Metropolitan University
**Completed:** December 2025
**Author:** Andrew Tao

---

## Overview

The design is split into four components that are developed and tested separately, then wired together in a top-level schematic:

| Component | Role |
|---|---|
| **Storage units (registers)** | Two 8-bit clocked registers hold inputs `A` and `B` |
| **Control unit** | A 9-state FSM feeds a 4-to-16 decoder that generates the ALU operation-select microcode |
| **ALU core** | Performs the selected arithmetic or logic operation on `A` and `B` |
| **Output display** | Shows the 8-bit `Result` as two hex digits on 7-segment displays, plus a negative-result indicator |

## Architecture

```
            Clock ─────────────┬──────────────┬──────────────┐
                               │              │              │
  A (8-bit) ──► [ Register 1 ] ─┤              │              │
                               ▼              │              │
                           ┌───────┐          │              │
                           │       │          │              │
  B (8-bit) ──► [ Register 2 ] ──► │  ALU  │ ──► Result (8-bit) ──► 7-segment displays
                           │       │                         (hex, low + high nibble)
                           └───▲───┘
                               │ OP (16-bit one-hot microcode)
                       ┌───────┴────────┐
        Clock ───────► │ Control Unit   │
                       │  FSM ─► 4x16   │ ──► student_id nibble ──► 7-segment display
                       │       decoder  │
                       └────────────────┘
```

## Modules

### Register (storage unit)
- 8-bit register with a clock and an active-low reset (`Resetn`).
- Captures its input on the rising clock edge; reset forces the output to `00000000`.
- Instantiated twice, once for `A` and once for `B`.

### Control unit

**FSM**
- Nine states (0 to 8) cycled by the clock.
- Initially behaves as an up-counter: states advance 0 → 8, then wrap back to 0.
- Outputs a 4-bit `current_state` to the decoder and a 4-bit `student_id` value for its own 7-segment display.

**4-to-16 decoder**
- Built from two 3-to-8 decoders using the select bits `S0`–`S2` and an enable derived from `S3` and `En`, as in the lab schematic.
- Produces the 16-bit one-hot `OP` microcode sent to the ALU.

### ALU core
- Inputs: `A`, `B` (8-bit), `OP` (16-bit), `Clock`.
- Outputs: `Result` (8-bit), a `Neg` flag for negative subtraction results, and two 4-bit halves of the result (`R1` low nibble, `R2` high nibble) for the hex displays.
- Operations are evaluated on the rising clock edge using a `case` statement on `OP`.

## ALU operations

Only nine of the sixteen microcode bits are used. Each microcode is one-hot.

| # | Microcode (16-bit) | Operation |
|---|---|---|
| 1 | `0000000000000001` | `A + B` (sum) |
| 2 | `0000000000000010` | `A - B` (difference, sets `Neg` if negative) |
| 3 | `0000000000000100` | NOT `A` |
| 4 | `0000000000001000` | `A NAND B` |
| 5 | `0000000000010000` | `A NOR B` |
| 6 | `0000000000100000` | `A AND B` |
| 7 | `0000000001000000` | `A XOR B` |
| 8 | `0000000010000000` | `A OR B` |
| 9 | `0000000100000000` | `A XNOR B` |

Any other `OP` value is treated as a don't-care.

## Inputs

`A` and `B` are 8-bit values. In simulation they are set in the Quartus waveform editor, and in this project they are derived from the last four digits of a student ID (two digits per input, converted to 8-bit binary).

Example of the conversion: digits `43` and `95` become `A = 0100 0011` and `B = 1001 0101`.

## Displaying the output

- **Simulation:** `Result` is shown in binary in the waveform editor.
- **FPGA:** `Result` is split into two 4-bit nibbles and shown on two 7-segment displays in hexadecimal. A third display shows the FSM `student_id` value. The `Neg` flag drives the minus segment when a subtraction result is negative.

## Project extensions

Beyond the base nine operations, the ALU was extended with additional custom operations (for example shifts, rotates, min/max, 2's complement, and bit-swapping).

> **TODO:** list the exact operations you were assigned and implemented.

## Tools

- Quartus II (VHDL entry, schematic top-level, synthesis, functional simulation)
- Altera/Intel FPGA development board
- Quartus waveform editor for simulation

> **TODO:** add your exact board model (for example, the DE-series board name) and Quartus version.

## How to build and simulate

1. Open the project in Quartus II.
2. Compile each VHDL module (register, FSM, decoder, ALU core) and generate a symbol for each one.
3. In the top-level block schematic (`.bdf`), place the symbols: two registers, FSM, 4-to-16 decoder, ALU core, and the 7-segment display decoders.
4. Create the input ports `A[7..0]`, `B[7..0]`, `Clock`, and `Resetn`, and the output port `Result[7..0]`. Connect and label the buses (for example `OP`, `A`, `B`).
5. Run **Analysis & Synthesis** and then a **functional simulation** using a vector waveform file with your chosen `A` and `B` values.
6. Check that `Result` matches the expected value for each of the nine states.

To program the board, assign the pins for the clock, inputs, and 7-segment displays, compile, and download the `.sof` file with the Quartus Programmer.

## Verification

Each module was tested on its own before integration (register behaviour checked against a truth table, FSM state sequence, decoder outputs), and the full design was verified in functional simulation. Waveforms for each operation step confirm the ALU result for the chosen `A` and `B`.

> **TODO:** add screenshots of your waveforms (for example under `docs/`) and note any timing or logic bugs you fixed along the way.

## Repository structure

> **TODO:** update this to match your actual file names.

```
.
├── README.md
├── register.vhd        # 8-bit register (storage unit)
├── fsm.vhd             # 9-state FSM
├── decoder_3x8.vhd     # 3-to-8 decoder
├── decoder_4x16.vhd    # 4-to-16 decoder built from 3-to-8 decoders
├── alu.vhd             # ALU core
├── top_level.bdf       # Top-level schematic
├── simulation/         # Waveform files (.vwf)
└── docs/               # Screenshots and lab report
```

## What I learned

- Structuring a larger digital design into separate, testable modules and integrating them at the top level
- Designing and sequencing a finite state machine
- Building a wider decoder from smaller ones using enable logic
- Synthesizing VHDL for an FPGA and debugging timing and logic issues with waveform analysis
