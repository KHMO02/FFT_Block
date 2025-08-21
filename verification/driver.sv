class driver;

    transaction tr;
    virtual FFT_if i1;
    mailbox #(transaction) seq_to_drv;

    function new();
    endfunction //new()

    task start();
        tr = new();
        forever begin
            seq_to_drv.get(tr);
            @(negedge i1.clk);
            // $display("negedge got triggered @ %0t",$time);
            i1.rst_n <= tr.rst_n;
            i1.x_r <= tr.x_r;
            i1.x_i <= tr.x_i;
        end
    endtask

    task set_mailbox(input mailbox #(transaction) seq_to_drv);
        this.seq_to_drv = seq_to_drv;
    endtask


endclass //driver