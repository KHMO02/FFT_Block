module fft_2(input wire clk, rst_n, cnt_in_en, input signed [11:0] x_r, x_i, output reg signed [11:0] X_r,X_i);

reg signed [11:0] buff_r;
reg signed [11:0] buff_i;
reg counter;
integer i;

wire signed [11:0] butter1_r,butter1_i,butter2_r,butter2_i;
wire signed [11:0] fixed_w_i,fixed_w_r;
reg signed [11:0] w_r,w_i;

butterfly b1(
    .x1_r(buff_r),
    .x1_i(buff_i),
    .x2_r(x_r),
    .x2_i(x_i),
    .w_r(w_r),
    .w_i(w_i),
    .X1_r(butter1_r),
    .X1_i(butter1_i),
    .X2_r(butter2_r),
    .X2_i(butter2_i)
);
assign fixed_w_r = {12'd1024};
assign fixed_w_i = {12'd0};



always @(posedge clk) begin
    if(!rst_n) begin
        buff_r<=0;
        buff_i<=0;
        counter <= 0;
        X_r <= 0;
        X_i <= 0;
    end
    else begin
        if(counter<1) begin
            X_r <= buff_r;
            X_i <= buff_i;
            buff_r <= x_r;
            buff_i <= x_i;
        end
        else begin
            X_r <= butter1_r;
            X_i <= butter1_i;
            buff_r <= butter2_r;
            buff_i <= butter2_i;
        end
        if(cnt_in_en) counter <= counter+1;
    end

end

always @(*) begin
    if(counter>=1) begin
        w_r = fixed_w_r;
        w_i = fixed_w_i;
    end
end



endmodule