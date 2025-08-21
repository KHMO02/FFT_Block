class env;

    sequencer seq;
    driver drv;
    subscriber sub;
    monitor mntr;
    scoreboard scr;
    mailbox #(transaction) mntr_to_score = new(1);
    mailbox #(transaction) mntr_to_sub = new(1);
    mailbox #(transaction) seq_to_drv = new(1);


    function new();
        seq = new();
        drv = new();
        sub = new();
        mntr = new();
        scr = new();
    endfunction


    task start();
        mntr.set_score_mailbox(mntr_to_score);
        mntr.set_sub_mailbox(mntr_to_sub);
        scr.set_score_mailbox(mntr_to_score);
        sub.set_sub_mailbox(mntr_to_sub);
        drv.set_mailbox(seq_to_drv);
        seq.set_mailbox(seq_to_drv);
        fork
            seq.start();
            drv.start();
            mntr.start();
            scr.start();
            sub.start();
        join_none
        wait(scr.total_tests==scr.number_of_tests)
        $display("NUMBER OF TESTS = %0d",scr.number_of_tests);
        $display("NUMBER OF SUCCEDED TESTS = %0d",scr.succeded_tests);
        $display("NUMBER OF FAILED TESTS = %0d",scr.failed_tests);
        $stop();
    endtask 


endclass //env