class scoreboard;
    mailbox agt2scb; // Chứa input từ Agent gọi tới
    mailbox scb2chk; // Gửi expected output sang bộ phận Checker

    function new(mailbox agt2scb, mailbox scb2chk);
        this.agt2scb = agt2scb;
        this.scb2chk = scb2chk;
    endfunction

    task run();
        transaction tr;
        transaction exp_tr;
        forever begin
            agt2scb.get(tr);
            
            exp_tr = new();
            // Giả lập chức năng của phần cứng (Reference Model) để tính kết quả đầu ra
            // exp_tr.dout = function_reference_model(tr.din);  

            // Đưa dữ liệu kỳ vọng qua Checker để so sánh
            scb2chk.put(exp_tr);
            $display("[SCOREBOARD] Tinh toan xong va put expected data sang Checker!");
        end
    endtask
endclass
