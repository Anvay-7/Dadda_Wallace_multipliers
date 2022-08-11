`timescale 1ns / 1ps
// 8x8 Wallace Multiplier
module wallace(
    A, B, P
);
    parameter len = 8;

    input [len-1:0] A, B; // Multiplicand and Multiplier
    output wire [len*2:0]P; // Product

    reg [len-1:0]p[len-1:0]; // Partial Products

    wire [15:0]a, b;

    wire [14:0] hc, hs; // Half Adder Sum and Carry
    wire [37:0] fc, fs; // Full Adder Sum and Carry

    integer i ,j; // Loop Variables

    always @(A, B) begin
        for (i = 0; i < len; i = i + 1) begin
            for (j = 0; j < len; j = j + 1) begin
                p[i][j] = A[j]&B[i];
            end
        end             
    end

// Stage 1
    HA ha0 (p[1][0], p[0][1], hs[0], hc[0]);
    HA ha1 (p[1][3], p[0][4], hs[1], hc[1]);
    HA ha2 (p[7][1], p[6][2], hs[2], hc[2]);
    HA ha3 (p[7][4], p[6][5], hs[3], hc[3]);

    FA fa0 (p[2][0], p[1][1], p[0][2], fs[0], fc[0]);
    FA fa1 (p[3][0], p[2][1], p[1][2], fs[1], fc[1]);
    FA fa2 (p[4][0], p[3][1], p[2][2], fs[2], fc[2]);
    FA fa3 (p[5][0], p[4][1], p[3][2], fs[3], fc[3]);
    FA fa4 (p[2][3], p[1][4], p[0][5], fs[4], fc[4]);
    FA fa5 (p[6][0], p[5][1], p[4][2], fs[5], fc[5]);
    FA fa6 (p[3][3], p[2][4], p[1][5], fs[6], fc[6]);
    FA fa7 (p[7][0], p[6][1], p[5][2], fs[7], fc[7]);
    FA fa8 (p[4][3], p[3][4], p[2][5], fs[8], fc[8]);
    FA fa9 (p[5][3], p[4][4], p[3][5], fs[9], fc[9]);
    FA fa10 (p[7][2], p[6][3], p[5][4], fs[10], fc[10]);
    FA fa11 (p[7][3], p[6][4], p[5][5], fs[11], fc[11]);
    

// Stage 2
    HA ha4 (hc[0], fs[0], hs[4], hc[4]);
    HA ha5 (fs[6], p[0][6], hs[5], hc[5]);
    HA ha6 (p[7][6], p[6][7], hs[6], hc[6]);

    FA fa12 (fc[0], fs[1], p[0][3], fs[12], fc[12]);
    FA fa13 (fc[1], fs[2], hs[1], fs[13], fc[13]);
    FA fa14 (fc[2], hc[1], fs[3], fs[14], fc[14]);
    FA fa15 (fc[3], fc[4], fs[5], fs[15], fc[15]);
    FA fa16 (fc[5], fc[6], fs[7], fs[16], fc[16]);
    FA fa17 (fs[8], p[1][6], p[0][7], fs[17], fc[17]);
    FA fa18 (fc[7], fc[8], hs[2], fs[18], fc[18]);
    FA fa19 (fs[9], p[2][6], p[1][7], fs[19], fc[19]);
    FA fa20 (hc[2], fc[9], fs[10], fs[20], fc[20]);
    FA fa21 (p[4][5], p[3][6], p[2][7], fs[21], fc[21]);
    FA fa22 (fc[10], fs[11], p[4][6], fs[22], fc[22]);
    FA fa23 (fc[11], hs[3], p[5][6], fs[23], fc[23]);
    FA fa24 (hc[3], p[7][5], p[6][6], fs[24], fc[24]);


// Stage 3
    HA ha7 (hc[4], fs[12], hs[7], hc[7]);
    HA ha8 (fc[12], fs[13], hs[8], hc[8]);
    HA ha9 (fc[22], fs[23], hs[9], hc[9]);
    HA ha10 (fc[23], fs[24], hs[10], hc[10]);
    
    FA fs25 (fc[13], fs[14], fs[4], fs[25], fc[25]);
    FA fs26 (fc[14], fs[15], hs[5], fs[26], fc[26]);
    FA fs27 (fc[15], hc[5], fs[16], fs[27], fc[27]);
    FA fs28 (fc[16], fc[17], fs[18], fs[28], fc[28]);
    FA fs29 (fc[18], fc[19], fs[20], fs[29], fc[29]);
    FA fs30 (fc[20], fc[21], fs[22], fs[30], fc[30]);


// Stage 4
    HA ha11 (hc[7], hs[8], hs[11], hc[11]);
    HA ha12 (hc[8], fs[25], hs[12], hc[12]);
    HA ha13 (fc[25], fs[26], hs[13], hc[13]);
    HA ha14 (hc[6], p[7][7], hs[14], hc[14]);
    
    FA fs31 (fc[26], fs[27], fs[17], fs[31], fc[31]);
    FA fs32 (fc[27], fs[28], fs[19], fs[32], fc[32]);
    FA fs33 (fc[28], fs[29], fs[21], fs[33], fc[33]);
    FA fs34 (fc[29], fs[30], p[3][7], fs[34], fc[34]);
    FA fs35 (fc[30], hs[9], p[4][7], fs[35], fc[35]);
    FA fs36 (hc[9], hs[10], p[5][7], fs[36], fc[36]);
    FA fs37 (hc[10], fc[24], hs[6], fs[37], fc[37]);


// Stage 5
    assign a = {1'b0, fc[37], fc[36], fc[35], fc[34], fc[33], fc[32], fc[31], hc[13], hc[12], hc[11], hs[11], hs[7], hs[4], hs[0], p[0][0]};
    assign b = {hc[14], hs[14], fs[37], fs[36], fs[35], fs[34], fs[33], fs[32], fs[31], hs[13], hs[12], 5'b0};

    CLA16bit cla (a, b, 1'b0, P[15:0], P[16]); // CLA Instantiation

endmodule
