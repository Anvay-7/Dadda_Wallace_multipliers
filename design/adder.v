`timescale 1ns / 1ps

module adder(
    A, B, S
    );
    input [14:0]A, B;
    output [15:0]S;

    assign S = A + B;
    
endmodule
