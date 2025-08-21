module butterfly (
    input signed [11:0] x1_r,
    input signed [11:0] x1_i,
    input signed [11:0] x2_r,
    input signed [11:0] x2_i,
    input signed [11:0] w_r,
    input signed [11:0] w_i,
    output reg signed [11:0] X1_r,
    output reg signed [11:0] X1_i,
    output reg signed [11:0] X2_r,
    output reg signed [11:0] X2_i
);

reg signed [23:0] ac,bd,ad,bc;
reg signed [12:0] sum_r,sum_i;
reg signed [23:0] s_r,s_i;


always @(*) begin
    sum_r = x1_r + x2_r;    
    sum_i = x1_i + x2_i;


    X1_r = sum_r[11:0];
    X1_i = sum_i[11:0];


    ac = (x1_r - x2_r) * w_r;
    bd = (x1_i - x2_i) * w_i;
    ad = (x1_r - x2_r) * w_i;
    bc = (x1_i - x2_i) * w_r;

    s_r = (ac - bd) >>> 10;
    s_i = (ad + bc) >>> 10;

    X2_r = s_r[11:0];
    X2_i = s_i[11:0];

end
    
endmodule

