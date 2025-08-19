module test ();

function real q5_7_to_real(input logic signed [11:0] val);
    // Interpret directly as signed 12-bit integer (two's complement handled automatically)
    // Then scale by 2^-7 to account for the fractional part
    q5_7_to_real = $itor(val) / (2.0**7);
endfunction

// Converts real -> signed [11:0] in Q5.7 format
function automatic logic signed [11:0] real_to_q57 (input real val);
    int tmp;
    begin
        // Scale up by 2^7 (shift the binary point)
        tmp = $rtoi(val * (2.0**7));  // exact for binary fractions
        
        // Saturate to 12-bit signed range (-2048 to 2047)
        if (tmp >  2047)      tmp =  2047;
        else if (tmp < -2048) tmp = -2048;

        real_to_q57 = tmp[11:0]; // Truncate into 12 bits
    end
endfunction

initial begin
    logic signed [11:0] x=12'b000101000101;
    $display("Binary: %12b",x);
    $display("decimal fraction: %0f", q5_7_to_real(x));
    $display("Binary after restore: %12b",real_to_q57(q5_7_to_real(x)));

end
    
endmodule