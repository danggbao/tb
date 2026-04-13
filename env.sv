class environment;
    generator     gen;
    agent         agt;
    driver        drv;
    monitor       mon;
    scoreboard    scb;
    checker_block chk;

    // Mailboxes kết nối các components
    mailbox gen2agt;
    mailbox agt2drv;
    mailbox agt2scb;
    mailbox mon2chk;
    mailbox scb2chk;

    // Events đồng bộ quá trình
    event agent_done;
    event drv_done;

    virtual intf inf;

    function new(virtual intf inf);
        this.inf = inf;

        // 1. Khởi tạo mailboxes
        gen2agt = new();
        agt2drv = new();
        agt2scb = new();
        mon2chk = new();
        scb2chk = new();

        // 2. Khởi tạo các blocks (components)
        gen = new(gen2agt);
        agt = new(gen2agt, agt2drv, agt2scb);
        drv = new(agt2drv, inf);
        scb = new(agt2scb, scb2chk);
        mon = new(mon2chk, inf);
        chk = new(scb2chk, mon2chk);

        //Ket noi cac event
        gen.agent_done = agent_done;
        agt.agent_done = agent_done;
        agt.drv_done = drv_done;
        drv.drv_done = drv_done;
        
    endfunction

    task run();
        // Chạy song song tất cả các khối
        fork
            gen.run();
            agt.run();
            drv.run();
            scb.run();
            mon.run();
            chk.run();
        join_any
    endtask
endclass
