class monitor;
    mailbox mon2chk; // Gửi kết quả ngõ ra thu thập được tới Checker
    virtual intf inf;

    function new(mailbox mon2chk, virtual intf inf);
        this.mon2chk = mon2chk;
        this.inf = inf;
    endfunction

    task run();
        transaction tr;
        forever begin
            // Đợi 1 nhịp clock và bắt dữ liệu xuất ra thực tế từ DUT
            @(posedge inf.clk);
            tr = new();
            // tr.dout = inf.dout; // Thu thập data
            
            mon2chk.put(tr);
            $display("[MONITOR] Da lay mau va put data sang Checker!");
        end
    endtask
endclass