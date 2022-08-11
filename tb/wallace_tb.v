`timescale 1ns / 1ps

module wallace_tb(

    );

    parameter [8:1]c = 8'b11011110;
    reg [7:0]s;
   
    reg [7:0] A, B;
    wire [16:0] P;
    // wire [16:0] P;

    integer i;
   
    // dadda dut (.A(A), .B(B), .P(P));
    wallace dut (.A(A), .B(B), .P(P));

    initial begin
        A = 0;
        B = 0;
        s = 8'b0000001;
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

