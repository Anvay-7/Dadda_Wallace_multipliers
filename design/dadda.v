`timescale 1ns / 1ps
// 8x8 Dadda Multiplier
module dadda(
    A, B, P
   );

   parameter len = 8;
   
   input [len-1:0] A, B; // Multiplicand and Multiplier
   output wire [len*2-1:0] P; // Product

   reg [len-1:0]p[len-1:0]; // Partial Prodct

   wire [15:0] a, b;

   wire [7:0] hc, hs; // Half Adder Carry and Sum
   wire [34:0] fc, fs; // Full Addr Carry and Sum
   wire cout;

   integer i ,j; // Loop Variables

    always @(A, B) begin
        for (i = 0; i < len; i = i + 1) begin
            for (j = 0; j < len; j = j + 1) begin
                p[i][j] = A[j]&B[i];
            end
        end            
    end

// Stage 1
    HA ha0 (p[6][0], p[5][1], hs[0], hc[0]);
    HA ha1 (p[4][3], p[3][4], hs[1], hc[1]);
    HA ha2 (p[4][4], p[3][5], hs[2], hc[2]);

    FA fa0 (p[7][0], p[6][1], p[5][2], fs[0], fc[0]);
    FA fa1 (p[7][1], p[6][2], p[5][3], fs[1], fc[1]);
    FA fa2 (p[7][2], p[6][3], p[5][4], fs[2], fc[2]);


// Stage 2
    HA ha3 (p[4][0], p[3][1], hs[3], hc[3]);
    HA ha4 (p[2][3], p[1][4], hs[4], hc[4]);

    FA fa3 (p[5][0], p[4][1], p[3][2], fs[3], fc[3]);
    FA fa4 (hs[0], p[4][2], p[3][3], fs[4], fc[4]);
    FA fa5 (p[2][4], p[1][5], p[0][6], fs[5], fc[5]);
    FA fa6 (hc[0], fs[0], hs[1], fs[6], fc[6]);
    FA fa7 (p[2][5], p[1][6], p[0][7], fs[7], fc[7]);
    FA fa8 (fc[0], hc[1], fs[1], fs[8], fc[8]);
    FA fa9 (hs[2], p[2][6], p[1][7], fs[9], fc[9]);
    FA fa10 (fc[1], hc[2], fs[2], fs[10], fc[10]);
    FA fa11 (p[4][5], p[3][6], p[2][7], fs[11], fc[11]);    
    FA fa12 (fc[2], p[7][3], p[6][4], fs[12], fc[12]);
    FA fa13 (p[5][5], p[4][6], p[3][7], fs[13], fc[13]);
    FA fa14 (p[7][4], p[6][5], p[5][6], fs[14], fc[14]);


// Stage 3
    HA ha5 (p[3][0], p[2][1], hs[5], hc[5]);

    FA fa15 (hs[3], p[2][2], p[1][3], fs[15], fc[15]);
    FA fa16 (hc[3], fs[3], hs[4], fs[16], fc[16]);
    FA fa17 (fc[3], hc[4], fs[4], fs[17], fc[17]);
    FA fa18 (fc[4], fc[5], fs[6], fs[18], fc[18]);
    FA fa19 (fc[6], fc[7], fs[8], fs[19], fc[19]);    
    FA fa20 (fc[8], fc[9], fs[10], fs[20], fc[20]);
    FA fa21 (fc[10], fc[11], fs[12], fs[21], fc[21]);
    FA fa22 (fc[12], fc[13], fs[14], fs[22], fc[22]);
    FA fa23 (fc[14], p[7][5], p[6][6], fs[23], fc[23]);


// Stage 4
    HA ha6 (p[2][0], p[1][1], hs[6], hc[6]);

    FA fa24 (hs[5], p[1][2], p[0][3], fs[24], fc[24]);
    FA fa25 (hc[5], fs[15], p[0][4], fs[25], fc[25]);
    FA fa26 (fc[15], fs[16], p[0][5], fs[26], fc[26]);
    FA fa27 (fc[16], fs[17], fs[5], fs[27], fc[27]);
    FA fa28 (fc[17], fs[18], fs[7], fs[28], fc[28]);
    FA fa29 (fc[18], fs[19], fs[9], fs[29], fc[29]);
    FA fa30 (fc[19], fs[20], fs[11], fs[30], fc[30]);
    FA fa31 (fc[20], fs[21], fs[13], fs[31], fc[31]);
    FA fa32 (fc[21], fs[22], p[4][7], fs[32], fc[32]);
    FA fa33 (fc[22], fs[23], p[5][7], fs[33], fc[33]);
    FA fa34 (fc[23], p[7][6], p[6][7], fs[34], fc[34]);


// Stage 5
    assign a = {1'b0, fc[34], fc[33], fc[32], fc[31], fc[30], fc[29], fc[28], fc[27], fc[26], fc[25], fc[24], hc[6], hs[6], p[1][0], p[0][0]};
    assign b = {1'b0, p[7][7], fs[34], fs[33], fs[32], fs[31], fs[30], fs[29], fs[28], fs[27], fs[26], fs[25], fs[24], p[0][2], p[0][1], 1'b0};

    CLA16bit cla (a, b, 1'b0, P, cout); // CLA Instantiation 
    
endmodule
