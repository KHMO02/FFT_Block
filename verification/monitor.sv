class monitor;

    transaction tr;
    virtual FFT_if i1;
    mailbox #(transaction) mntr_to_score;
    mailbox #(transaction) mntr_to_sub;
    

    function new();
        
    endfunction

    task start();
        forever begin
            tr = new();
            @(posedge i1.mntr);       
            tr.x_i = i1.mntr.x_i;
            tr.x_r = i1.mntr.x_r;
            tr.rst_n = i1.mntr.rst_n;
            tr.X_r = i1.mntr.X_r;
            tr.X_i = i1.mntr.X_i;
            if(!$isunknown(tr.X_r)) begin
                mntr_to_score.put(tr);
                mntr_to_sub.put(tr);
            end
        end
    endtask


    task set_score_mailbox(input mailbox #(transaction) mntr_to_score);
        this.mntr_to_score = mntr_to_score;
    endtask
    task set_sub_mailbox(input mailbox #(transaction) mntr_to_sub);
        this.mntr_to_sub = mntr_to_sub;
    endtask
    // task set_interface(input virtual FFT_if i1);
    //     this.i1 = i1;
    // endtask
endclass