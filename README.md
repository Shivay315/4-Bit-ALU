# 4-Bit Signed ALU in Verilog 🚀

## 💡 Project Overview

This project presents a **4-bit signed Arithmetic Logic Unit (ALU)** built using Verilog HDL. The ALU supports **arithmetic**, **logical**, and **bitwise operations** with additional condition flags that mimic the behavior of a real processor. Designed with readability, expandability, and testability in mind, this module can be easily integrated into larger digital systems.

## ✨ Features

- **Supports 8 operations:** Clear, Add, Subtract, AND, OR, NOT A, NOT B, XOR  
- **Handles signed 2's complement numbers**
- **4-bit signed result with 5-bit internal precision for overflow/carry**
- **Flag outputs:**  
  - `c_out` - Carry/Borrow  
  - `zero_flag` - Result is zero  
  - `overflow_flag` - Signed overflow occurred  
  - `negative_flag` - Result is negative

## 🛠️ Module Description

### 🔧 Port Definitions

| Port Name     | Direction | Width  | Description                            |
|---------------|-----------|--------|----------------------------------------|
| `A`           | Input     | 4-bit  | First operand (signed)                 |
| `B`           | Input     | 4-bit  | Second operand (signed)                |
| `Op`          | Input     | 4-bit  | Operation select signal                |
| `alu_out`     | Output    | 4-bit  | Output result of ALU                   |
| `c_out`       | Output    | 1-bit  | Carry-out / Borrow flag                |
| `zero_flag`   | Output    | 1-bit  | Set if result is zero                  |
| `overflow_flag` | Output  | 1-bit  | Set if signed overflow occurs          |
| `negative_flag` | Output  | 1-bit  | Set if result is negative              |

### 📟 Operation Codes

| `Op` Code | Operation | Description                    |
|-----------|-----------|--------------------------------|
| `0000`    | Clear     | Result = 0                     |
| `0001`    | ADD       | Adds A and B                   |
| `0010`    | SUB       | Subtracts B from A             |
| `0011`    | AND       | Bitwise AND of A and B         |
| `0100`    | OR        | Bitwise OR of A and B          |
| `0101`    | NOT A     | Bitwise NOT of A               |
| `0110`    | NOT B     | Bitwise NOT of B               |
| `0111`    | XOR       | Bitwise XOR of A and B         |

## 📦 ALU Verilog Code

```verilog
`timescale 1ns / 1ps

module alu(
    input signed [3:0] A, B,
    input [3:0] Op,
    output reg signed [3:0] alu_out,
    output reg c_out,
    output reg zero_flag,
    output reg overflow_flag,
    output reg negative_flag
);

reg signed [4:0] temp_result;

always @(*) begin
    temp_result = 0;
    c_out = 0;
    overflow_flag = 0;

    case(Op)
        4'b0000 : alu_out = 4'b0000;  // Clear
        4'b0001 : begin              // ADD
            temp_result = A + B;
            alu_out = temp_result[3:0];
            c_out = temp_result[4];
            overflow_flag = (~A[3] & ~B[3] & alu_out[3]) | (A[3] & B[3] & ~alu_out[3]);
        end
        4'b0010 : begin              // SUB
            temp_result = A - B;
            alu_out = temp_result[3:0];
            c_out = temp_result[4];
            overflow_flag = (~A[3] & B[3] & alu_out[3]) | (A[3] & ~B[3] & ~alu_out[3]);
        end
        4'b0011 : alu_out = A & B;   // AND
        4'b0100 : alu_out = A | B;   // OR
        4'b0101 : alu_out = ~A;      // NOT A
        4'b0110 : alu_out = ~B;      // NOT B
        4'b0111 : alu_out = A ^ B;   // XOR
        default: alu_out = 4'b0000;
    endcase

    zero_flag = (alu_out == 4'b0000);
    negative_flag = alu_out[3];
end

endmodule
