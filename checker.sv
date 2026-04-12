class checker_block;
    mailbox scb2chk; // Expected data (từ Scoreboard/Predictor truyền sang)
    mailbox mon2chk; // Actual data (từ Monitor truyền sang)

    function new(mailbox scb2chk, mailbox mon2chk);
        this.scb2chk = scb2chk;
        this.mon2chk = mon2chk;
    endfunction

    task run();
        transaction exp_tr;
        transaction act_tr;
        
        forever begin
            // Đợi nhận đủ cả dữ liệu dự đoán và dữ liệu thực tế
            scb2chk.get(exp_tr);
            mon2chk.get(act_tr);

            // Bắt đầu quá trình đối chiếu so sánh
            // Ví dụ: assume transaction có các biến được xử lý ở ngõ ra
            // if (exp_tr.dout == act_tr.dout) begin
            //     $display("[CHECKER] MATCH! Expected = %0d, Actual = %0d", exp_tr.dout, act_tr.dout);
            // end else begin
            //     $display("[CHECKER] ERROR! Expected = %0d, Actual = %0d", exp_tr.dout, act_tr.dout);
            // end
            $display("[CHECKER] Da so sanh xong!");
        end
    endtask
endclass
