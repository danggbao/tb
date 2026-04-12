class agent;
    mailbox gen2agt;
    mailbox agt2drv;
    mailbox agt2scb;
    event  agent_done;
    event  drv_done;

    function new(mailbox gen2agt, mailbox agt2drv, mailbox agt2scb, event agent_done, event drv_done);
        this.gen2agt = gen2agt;
        this.agt2drv = agt2drv;
        this.agt2scb = agt2scb;
        this.agent_done = agent_done;
        this.drv_done = drv_done;
    endfunction
    task run();
        transaction tr;
        forever begin
            gen2agt.get(tr);
            agt2drv.put(tr);
            agt2scb.put(tr);
            -> agent_done;
            $display("[agt] put done");
            @(drv_done);
        end
    endtask
endclass