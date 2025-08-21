module FFT_top (input wire clk, rst_n, input signed [11:0] x_real, x_imag, output signed [11:0] X_r,X_i);

wire signed [11:0] out1_r,out1_i,out2_r,out2_i;
wire cnt1,cnt2;
wire signed [11:0] x_input_i,x_input_r;
assign x_input_r = x_real >>> 2;
assign x_input_i = x_imag >>> 2;

fft_8 s1(.clk(clk),.rst_n(rst_n),.x_r(x_input_r),.x_i(x_input_i),.X_r(out1_r),.X_i(out1_i), .cnt_out_en(cnt1));
fft_4 s2(.clk(clk),.rst_n(rst_n),.cnt_in_en(cnt1),.x_r(out1_r),.x_i(out1_i),.X_r(out2_r),.X_i(out2_i),.cnt_out_en(cnt2));
fft_2 s3(.clk(clk),.rst_n(rst_n),.cnt_in_en(cnt2),.x_r(out2_r),.x_i(out2_i),.X_r(X_r),.X_i(X_i));

    
endmodule