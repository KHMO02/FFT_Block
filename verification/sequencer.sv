class sequencer;

    transaction tr;
    integer fid_in;
    mailbox #(transaction) seq_to_drv;

    function new();
        
    endfunction

    task start();     
        fid_in = $fopen("input_bin.txt","r");   
        tr = new();
        //reset everything
        tr.rst_n = 0;
        tr.x_r = 0;
        tr.x_i = 0;
        seq_to_drv.put(tr);

        repeat(8000) begin
            tr = new();
            tr.rst_n = 1;
            $fscanf(fid_in,"%12b + %12b i",tr.x_r, tr.x_i);
            seq_to_drv.put(tr);
        end

        $fclose(fid_in);
    endtask

    task set_mailbox(input mailbox #(transaction) seq_to_drv);
        this.seq_to_drv = seq_to_drv;
    endtask
    
endclass //sequencer