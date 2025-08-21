class scoreboard;

    transaction tr;
    reg [11:0] expected_X_r;
    reg [11:0] expected_X_i;
    mailbox #(transaction) mntr_to_score;
    int total_tests = 0;
    int succeded_tests = 0;
    int failed_tests = 0;
    int number_of_tests = 8010;
    int fid_out;
    

    function new();
        
    endfunction

    task start();
        fid_out = $fopen("output_bin.txt","r");
        forever begin
            mntr_to_score.get(tr);
            if(total_tests<10) begin
                expected_X_i = 12'd0;
                expected_X_r = 12'd0;
            end
            else begin
                $fscanf(fid_out,"%12b + %12b i",expected_X_r, expected_X_i);
            end

            if (tr.X_r !== expected_X_r || tr.X_i !== expected_X_i) begin
                $display("[Scoreboard Mismatch] @ time = %0t, exp = %12b + %12b i , X = %12b + %12b i",$time,expected_X_r,expected_X_i, tr.X_r, tr.X_i);
                failed_tests++;
            end
            else begin
                $display("[Scoreboard match] @ time = %0t, exp = %12b + %12b i , X = %12b + %12b i",$time,expected_X_r,expected_X_i, tr.X_r, tr.X_i);
                succeded_tests++;
            end
            if (total_tests == 8009) $fclose(fid_out);
            total_tests++;
        end
    endtask

    task set_score_mailbox(input mailbox #(transaction) mntr_to_score);
        this.mntr_to_score = mntr_to_score;
    endtask
endclass //scoreboard