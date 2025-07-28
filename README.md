#  4-Bit Arithmetic Logic Unit (ALU) with Verilog

This project implements a simple 4-bit ALU in Verilog with an integrated **testbench** for simulation. It performs fundamental arithmetic and logic operations like **ADD**, **SUB**, **AND**, **OR**, **XOR**, **NOT**, and **CLEAR**, and includes flags for **carry**, **zero**, **overflow**, and **negative** detection.

## Project Structure

All Verilog modules and the testbench are contained within a single `.v` file for compactness and easy portability.

```
ALU.v  # Contains both the ALU and testbench
```

---

## ALU Functionality

The ALU supports the following operations based on the 4-bit opcode:

| Opcode | Operation | Description            |
|--------|-----------|------------------------|
| 0000   | Clear     | alu_out = 0            |
| 0001   | ADD       | alu_out = A + B        |
| 0010   | SUB       | alu_out = A - B        |
| 0011   | AND       | alu_out = A & B        |
| 0100   | OR        | alu_out = A \| B        |
| 0101   | NOT A     | alu_out = ~A           |
| 0110   | NOT B     | alu_out = ~B           |
| 0111   | XOR       | alu_out = A ^ B        |

Each operation sets the relevant status flags:
- **Carry Out (c_out)**
- **Zero Flag (zero_flag)**
- **Overflow Flag (overflow_flag)**
- **Negative Flag (negative_flag)**

---

## Testbench

This testbench simulates all operations supported by the ALU. The results can be observed using waveform simulation tools like **ModelSim**, **Vivado**, or **GTKWave**.

### Code

```verilog
module TB();
    reg [3:0] A, B;
    reg [3:0] Op;
    wire [3:0] alu_out;
    wire c_out, zero_flag, overflow_flag, negative_flag;

    alu a1(
        .A(A), .B(B), .Op(Op),
        .alu_out(alu_out),
        .c_out(c_out),
        .zero_flag(zero_flag),
        .overflow_flag(overflow_flag),
        .negative_flag(negative_flag)
    );

    initial begin
        A = 4'b0100; B = 4'b1000; Op = 4'b0000; #10;  // Clear
        A = 4'b0011; B = 4'b0111; Op = 4'b0001; #10;  // ADD
        A = 4'b0011; B = 4'b0101; Op = 4'b0010; #10;  // SUB
        A = 4'b0011; B = 4'b0001; Op = 4'b0011; #10;  // AND
        A = 4'b0011; B = 4'b0001; Op = 4'b0100; #10;  // OR
        A = 4'b0011; B = 4'b0001; Op = 4'b0101; #10;  // NOT A
        A = 4'b0011; B = 4'b0001; Op = 4'b0110; #10;  // NOT B
        A = 4'b0011; B = 4'b0001; Op = 4'b0111; #10;  // XOR

        $stop;
    end
endmodule
```

---

## Waveform Simulation Example

You can use ModelSim, Vivado, or GTKWave to run the testbench and view the signal behavior.

| Cycle | Operation | A     | B     | Result | c_out | zero | overflow | negative |
|-------|-----------|-------|-------|--------|--------|------|----------|----------|
| 0     | Clear     | 0100  | 1000  | 0000   | 0      | 1    | 0        | 0        |
| 1     | ADD       | 0011  | 0111  | 1010   | 0      | 0    | 1        | 1        |
| 2     | SUB       | 0011  | 0101  | 1110   | 1      | 0    | 0        | 1        |
| 3     | AND       | 0011  | 0001  | 0001   | -      | 0    | -        | 0        |
| 4     | OR        | 0011  | 0001  | 0011   | -      | 0    | -        | 0        |
| 5     | NOT A     | 0011  | xxxx  | 1100   | -      | 0    | -        | 1        |
| 6     | NOT B     | xxxx  | 0001  | 1110   | -      | 0    | -        | 1        |
| 7     | XOR       | 0011  | 0001  | 0010   | -      | 0    | -        | 0        |

---

## Design Considerations

- **Signed Handling**: Supports signed 2's complement arithmetic.
- **Internal 5-bit Logic**: Ensures overflow/carry is captured for 4-bit results.
- **Modular & Expandable**: Easy to extend to 8-bit or 16-bit ALUs.
- **Flag Output**: Useful for CPU design, debugging, or further processing.

---

## How to Run

1. Save the `ALU.v` file.
2. Open it in your favorite Verilog simulation tool (e.g., ModelSim, Vivado, GTKWave).
3. Compile and simulate the testbench.
4. Observe the waveform or console output for verification.

---

## Author

Made with ❤️ by Shivay 🌸

