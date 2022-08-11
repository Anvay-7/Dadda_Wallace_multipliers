`timescale 1ns / 1ps
// 4 Bit Carry Look Ahead Adder 
module CLA4bit(
    a, b, cin, sum, cout
    );

    input [3:0] a,b; // Addend and Augend
    input cin; // Carry In

    output [3:0] sum; // Sum
    output cout; // Carry Out
    
    wire [3:0] p,g,c;
    
    assign p=a^b; //propagation
    assign g=a&b; //generation
        
    assign c[0] = cin;
    assign c[1] = g[0] | (p[0]&c[0]);
    assign c[2] = g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
    assign c[3] = g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
    assign cout = g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
    assign sum = p^c;
 
endmodule
