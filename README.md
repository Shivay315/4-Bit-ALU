# 🧠 4-Bit Signed Arithmetic Logic Unit (ALU) with Testbench

This Verilog module implements a **4-bit signed Arithmetic Logic Unit (ALU)** along with a self-contained testbench. The ALU performs **eight distinct operations**, includes **comprehensive flag support** (zero, carry, overflow, and negative), and is designed to support signed arithmetic.

---

## 💡 Features

- **Signed 4-bit Arithmetic** (Two's complement)
- **Operation Codes (Op)**:
  - `0000` → Clear (Output = 0)
  - `0001` → Addition `A + B`
  - `0010` → Subtraction `A - B`
  - `0011` → Bitwise AND
  - `0100` → Bitwise OR
  - `0101` → Bitwise NOT A
  - `0110` → Bitwise NOT B
  - `0111` → Bitwise XOR
- **Status Flags**:
  - `c_out`: Carry out (for addition/subtraction overflow beyond 4 bits)
  - `overflow_flag`: Detects overflow for signed arithmetic
  - `zero_flag`: Indicates if output is zero
  - `negative_flag`: Indicates if output is negative (MSB = 1)

---

## 🔧 Internal Architecture

### `temp_result [4:0]`
A 5-bit signed temporary register used to store intermediate results in arithmetic operations to catch carry-out and overflow without data loss.

### Flag Logic:

```verilog
zero_flag = (alu_out == 4'b0000);
negative_flag = alu_out[3]; // MSB of 4-bit result

Overflow Conditions:
ADD:
verilog
Copy
Edit
overflow_flag = (~A[3] & ~B[3] & alu_out[3]) | (A[3] & B[3] & ~alu_out[3]);
SUB:
verilog
Copy
Edit
overflow_flag = (~A[3] & B[3] & alu_out[3]) | (A[3] & ~B[3] & ~alu_out[3]);
🔬 Testbench Design
The testbench instantiates the ALU module and applies a series of unit test cases for all operations with delays for simulation. Each test demonstrates flag and output behavior:

verilog
Copy
Edit
initial begin
    A = 4'b0100; B = 4'b1000; Op = 4'b000; #10;  // Clear
    A = 4'b0011; B = 4'b0111; Op = 4'b001; #10;  // ADD
    A = 4'b0011; B = 4'b0101; Op = 4'b010; #10;  // SUB
    A = 4'b0011; B = 4'b0001; Op = 4'b011; #10;  // AND
    A = 4'b0011; B = 4'b0001; Op = 4'b100; #10;  // OR
    A = 4'b0011; B = 4'b0001; Op = 4'b101; #10;  // NOT A
    A = 4'b0011; B = 4'b0001; Op = 4'b110; #10;  // NOT B
    A = 4'b0011; B = 4'b0001; Op = 4'b111; #10;  // XOR

    $stop;
end
Each test validates not only alu_out, but also the c_out, zero_flag, overflow_flag, and negative_flag behaviors — ideal for hardware-level verification and debugging.
