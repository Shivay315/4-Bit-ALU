# 🧮 4-bit ALU in Verilog

This is a simple implementation of a 4-bit Arithmetic and Logic Unit (ALU) written in Verilog HDL.  
It performs basic arithmetic and logic operations on two 4-bit inputs `A` and `B`, with the operation selected using a 3-bit opcode.

## 🔧 Features

The ALU supports the following operations:

| Op Code | Operation | Description         |
|---------|-----------|---------------------|
| 000     | CLR       | Clear output (0)    |
| 001     | ADD       | A + B               |
| 010     | SUB       | A - B               |
| 011     | AND       | A & B               |
| 100     | OR        | A \| B              |
| 101     | NOT A     | Bitwise NOT of A    |
| 110     | NOT B     | Bitwise NOT of B    |
| 111     | XOR       | A ^ B               |

## 📥 Inputs

- `A [3:0]`: 4-bit input
- `B [3:0]`: 4-bit input
- `Op [2:0]`: 3-bit opcode to select the operation

## 📤 Outputs

- `alu_out [3:0]`: 4-bit result of the operation
- `c_out [3:0]`: Optional carry/flag register (could be customized further for real flags)

## 📄 Testbench

A sample testbench is included to demonstrate functionality for all operations. You can simulate using any Verilog simulator like ModelSim, Vivado, or online tools.

### Sample Test Case Snippet:
```verilog
initial begin
    A = 4'b0100; B = 4'b1000; Op = 3'b000; #10;  // Clear
    A = 4'b0011; B = 4'b1001; Op = 3'b001; #10;  // ADD
    A = 4'b0011; B = 4'b0101; Op = 3'b010; #10;  // SUB
    A = 4'b0011; B = 4'b0001; Op = 3'b011; #10;  // AND
    A = 4'b0011; B = 4'b0001; Op = 3'b100; #10;  // OR
    A = 4'b0011; B = 4'b0001; Op = 3'b101; #10;  // NOT A
    A = 4'b0011; B = 4'b0001; Op = 3'b110; #10;  // NOT B
    A = 4'b0011; B = 4'b0001; Op = 3'b111; #10;  // XOR
    $stop;
end
