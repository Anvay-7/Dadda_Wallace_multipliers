`timescale 1ns / 1ps
// 16 Bit Carry Look Ahead Adder Module
module CLA16bit(
    a, b, cin, sum, cout
    );
    
    input [15:0] a,b; // Addend and Augend
    input cin; // Carry In

    output [15:0] sum; // Sum
    output cout; // Carry Out

    wire c1,c2,c3;

    // 4 Bit CLA Instantiation 
    CLA4bit cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c1));
    CLA4bit cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c1), .sum(sum[7:4]), .cout(c2));
    CLA4bit cla3 (.a(a[11:8]), .b(b[11:8]), .cin(c2), .sum(sum[11:8]), .cout(c3));
    CLA4bit cla4 (.a(a[15:12]), .b(b[15:12]), .cin(c3), .sum(sum[15:12]), .cout(cout));
 
endmodule
