module fft_8(input wire clk, rst_n, input signed [11:0] x_r, x_i, output reg signed [11:0] X_r,X_i, output reg cnt_out_en);

reg signed [11:0] buff_r [0:3];
reg signed [11:0] buff_i [0:3];
reg [2:0] counter;
integer i;

wire signed [11:0] butter1_r,butter1_i,butter2_r,butter2_i;
wire signed [11:0] fixed_w_i [0:3],fixed_w_r [0:3];
reg signed [11:0] w_r,w_i;

butterfly b1(
    .x1_r(buff_r[0]),
    .x1_i(buff_i[0]),
    .x2_r(x_r),
    .x2_i(x_i),
    .w_r(w_r),
    .w_i(w_i),
    .X1_r(butter1_r),
    .X1_i(butter1_i),
    .X2_r(butter2_r),
    .X2_i(butter2_i)
);
assign fixed_w_r[0] = 12'd1024;
assign fixed_w_r[1] = 12'd724;
assign fixed_w_r[2] = 12'd0;
assign fixed_w_r[3] = -12'd724;
assign fixed_w_i[0] = 12'd0;
assign fixed_w_i[1] = -12'd724;
assign fixed_w_i[2] = -12'd1024;
assign fixed_w_i[3] = -12'd724;

always @(posedge clk) begin
    if(!rst_n) begin
        for (i = 0; i<4 ; i=i+1 ) begin
            buff_r[i]<=0;
            buff_i[i]<=0;
        end
        counter <= 0;
        X_r <= 0;
        X_i <= 0;
    end
    else begin
        if(counter<4) begin
            X_r <= buff_r[0];
            X_i <= buff_i[0];
            buff_r[0] <= buff_r[1];
            buff_r[1] <= buff_r[2];
            buff_r[2] <= buff_r[3];
            buff_r[3] <= x_r;
            buff_i[0] <= buff_i[1];
            buff_i[1] <= buff_i[2];
            buff_i[2] <= buff_i[3];
            buff_i[3] <= x_i;
        end
        else begin
            X_r <= butter1_r;
            X_i <= butter1_i;
            buff_r[0] <= buff_r[1];
            buff_r[1] <= buff_r[2];
            buff_r[2] <= buff_r[3];
            buff_r[3] <= butter2_r;
            buff_i[0] <= buff_i[1];
            buff_i[1] <= buff_i[2];
            buff_i[2] <= buff_i[3];
            buff_i[3] <= butter2_i;
            cnt_out_en <= 1;
        end
        counter <= counter+1;
    end

end

always @(*) begin
    if(counter>=4) begin
        w_r = fixed_w_r[counter-4];
        w_i = fixed_w_i[counter-4];
    end
end



endmodule

