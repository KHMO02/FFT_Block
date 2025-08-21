vlog -cover f FFT_if.sv pack.sv tb.sv RTL/*.v
vsim -coverage tb -voptargs=+acc