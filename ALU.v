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
        4'b000 : alu_out = 4'b0000;                        // Clear
        4'b001 : begin                                     // ADD
            temp_result = A + B;
            alu_out = temp_result[3:0];
            c_out = temp_result[4];
            overflow_flag = (~A[3] & ~B[3] & alu_out[3]) | (A[3] & B[3] & ~alu_out[3]);
        end
        4'b010 : begin                                     // SUB
            temp_result = A - B;
            alu_out = temp_result[3:0];
            c_out = temp_result[4];
            overflow_flag = (~A[3] & B[3] & alu_out[3]) | (A[3] & ~B[3] & ~alu_out[3]);
        end
        4'b011 : alu_out = A & B;                          // AND
        4'b100 : alu_out = A | B;                          // OR
        4'b101 : alu_out = ~A;                             // NOT A
        4'b110 : alu_out = ~B;                             // NOT B
        4'b111 : alu_out = A ^ B;                          // XOR
        default: alu_out = 4'b0000;
    endcase

    zero_flag = (alu_out == 4'b0000);
    negative_flag = alu_out[3];
end

endmodule


// Testbench
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
endmodule
