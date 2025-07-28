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
