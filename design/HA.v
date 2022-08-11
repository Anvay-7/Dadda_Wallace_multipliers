`timescale 1ns / 1ps
// Half Adder Module
module HA (
    A, B, S, C
);
    input A, B; // Addend and Augend
    output S, C; // Sum and Carry

    assign {C, S} = A + B;
    
endmodule