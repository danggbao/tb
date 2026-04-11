class agent;
    mailbox gen2agt;
    mailbox agt2drv;
    mailbox agt2scb;
    event  agent_done;
    function new(mailbox gen2agt, mailbox agt2drv, mailbox agt2scb);
        this.gen2agt = gen2agt;
        this.agt2drv = agt2drv;
        this.agt2scb = agt2scb;
    endfunction
    task run();
        
    endtask
endclass