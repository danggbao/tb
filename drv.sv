class driver;
    mailbox agt2drv;
    event drv_done;
    virtual intf inf;
    function new(mailbox agt2drv, virtual intf inf);
        this.agt2drv = agt2drv;
        this.inf = inf;
    endfunction
    task run();
        transaction tr;
        forever begin
            agt2drv.get(tr);
            @(posedge inf.clk);

            -> drv_done;
            $display("[drv] put done");
        end
    endtask
endclass