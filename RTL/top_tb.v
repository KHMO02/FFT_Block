module tb ();

reg clk,rst_n;
reg signed [11:0] x_r,x_i ,exp_r,exp_i;
wire signed [11:0] X_r,X_i;
integer i;
integer j;
integer fid_in;
integer fid_out;
integer failed,Succeded;


top t1(.clk(clk),.rst_n(rst_n),.x_r(x_r),.x_i(x_i),.X_r(X_r),.X_i(X_i));

always begin
    #5 clk=!clk;
end

initial begin
    fid_in = $fopen("input_bin.txt","r");
    clk=0;rst_n=0;
    @(negedge clk);
    rst_n=1;
    for (i = 0; i<1600 ;i=i+1) begin
        $fscanf(fid_in,"%12b + %12b i",x_r, x_i);
        @(negedge clk);
    end
    $fclose(fid_in);
end
initial begin
    fid_out = $fopen("output_bin.txt","r");
    failed = 0;
    Succeded = 0;
    @(negedge clk)
    for (j = 0; j<10 ; j=j+1 ) begin
        @(negedge clk);
    end
    for (j = 0; j<1600 ; j=j+1 ) begin
        $fscanf(fid_out,"%12b + %12b i",exp_r, exp_i);
        if(exp_r == X_r && exp_i == X_i)begin
           $display("Succeded: exp = %12b + %12b i , X = %12b + %12b i",exp_r,exp_i,X_r,X_i);
           Succeded = Succeded+1; 
        end
        else begin
            $display("Failed: exp = %12b + %12b i , X = %12b + %12b i",exp_r,exp_i,X_r,X_i);
            failed = failed+1;
        end 
        @(negedge clk);
    end
    $fclose(fid_out);
    $display("Succeded = %0d, Failed = %0d", Succeded, failed);
    $stop;
end
    
endmodule