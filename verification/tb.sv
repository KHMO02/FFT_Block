`include "FFT_if.sv"
module tb ();
    import pack::*;
    
    bit clk;
    FFT_if i1(clk);
    FFT_top fft(.clk(i1.clk),.rst_n(i1.rst_n),.x_r(i1.x_r),.x_i(i1.x_i),.X_r(i1.X_r),.X_i(i1.X_i));
    env enviroment;

    always begin
        #5 clk=!clk;
    end


    initial begin
        enviroment = new();
        enviroment.drv.i1 = i1;
        enviroment.mntr.i1 = i1;
        enviroment.start();
    end

endmodule