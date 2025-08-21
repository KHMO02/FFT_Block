interface FFT_if(input logic clk);
    logic rst_n;
    logic [11:0] x_r;   
    logic [11:0] x_i;   
    logic [11:0] X_r;   
    logic [11:0] X_i;   


    clocking mntr @(posedge clk);
        input clk,rst_n,x_r,x_i;
        input #0 X_r,X_i;
    endclocking
endinterface //mem_pkg


