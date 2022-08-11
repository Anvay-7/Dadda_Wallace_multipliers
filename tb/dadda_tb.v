`timescale 1ns / 1ps
// Test Bench Module
module dadda_test_bench(

    );

    parameter [8:1]c = 8'b10011110; // Coefficients 
    reg [7:0]s; // Seed
   
    reg [7:0] A, B; // Multiplicand and Multplier

    // dadda Module Instantiation - Use for 8x8 Dadda Multiplier else comment wallace
    wire [15:0] P; // 16 bit Product
    dadda dut (.A(A), .B(B), .P(P));

    // wallace Module Instantiation - Use for 8x8 Wallace Multplier else comment for dadda
    // wire [16:0] P; // 17 bit Product
    // wallace dut (.A(A), .B(B), .P(P));
    
    integer i; // Loop Variable

    initial begin
        A = 0;
        B = 0;
        s = 8'b00000001;
        for (i = 0; i<8; i = i + 1) begin
            #100;
            if(s == 8'b11111111)
                s = 8'b00000001;
            if (c[i+1]) begin
                s[i+1] <= s[i]^s[7];
            end
            else begin
                s[i+1] <=  s[i];
            end
        end
        s[0] <= s[7];
        #100;
        $finish;
    end    
      
    always @ (s)begin       
        A = {s[7:4],~s[3:0]};
        B = {~s[7:4],s[3:0]};
    end   

endmodule
