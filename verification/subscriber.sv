class subscriber;

    transaction tr;
    mailbox #(transaction) mntr_to_sub;

    covergroup cg1();
        coverpoint tr.x_r;
        coverpoint tr.x_i;
        coverpoint tr.X_r;
        coverpoint tr.X_i;
    endgroup
    

    function new();
        cg1 = new();
    endfunction

    task start();
        forever begin
            tr = new();
            mntr_to_sub.get(tr);
            cg1.sample();
        end
    endtask

    task set_sub_mailbox(input mailbox #(transaction) mntr_to_sub);
        this.mntr_to_sub = mntr_to_sub;
    endtask

endclass //subscriber