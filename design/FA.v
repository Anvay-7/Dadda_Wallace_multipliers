`timescale 1ns / 1ps
// Full Adder Module
module FA (
    A, B, Cin, S, Cout
);
    input A, B, Cin; // Addend, Augend and Carry In
    output S, Cout; // Sum and Carry Out

    assign {Cout, S} = A + B + Cin;
    
endmodule