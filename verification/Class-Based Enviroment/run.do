vlog -cover bcstf FFT_if.sv pack.sv tb.sv RTL/*.v
vsim -coverage tb -voptargs=+acc
run -all