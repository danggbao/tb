class scoreboard;
    mailbox agt2scb; 
    mailbox scb2chk; 
    iq_filter_model ref_model;
    function new(mailbox agt2scb, mailbox scb2chk);
        this.agt2scb = agt2scb;
        this.scb2chk = scb2chk;
    endfunction

    task run();
        transaction tr;
        transaction exp_tr;
        forever begin
            agt2scb.get(tr);
            ref_model = new();
            exp_tr = new();
            
            
            // Đưa dữ liệu kỳ vọng qua Checker để so sánh với thực tiễn
            scb2chk.put(exp_tr);
            $display("[SCOREBOARD] Predictor: input=%0d, expected_out=%0d", tr.din, exp_tr.dout);
        end
    endtask
endclass
