`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2021 14:19:42
// Design Name: 
// Module Name: CLA_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CLA_tb(
    );

    reg [15:0] A, B;
    reg Cin;
    wire [15:0] S;
    wire Cout;

    CLA16bit dut (A, B, Cin, S, Cout);

    initial begin
        A = 8'd125;
        B = 8'd150;
        Cin = 8'd0;
    end

endmodule
