class generator;
    mailbox gen2agt;
    
    event agent_done;
    int repeat_count = 20;
    function new(mailbox gen2agt, event ev);
        this.gen2agt = gen2agt;
        this.agent_done = ev;
    endfunction
    task run();
        transaction tr;
        repeat(repeat_count) begin
            tr = new();
            if(!tr.randomize()) begin
                $display("[gen] randomize failed");
            end
            gen2agt.put(tr);
            @(agent_done);
        end
    endtask
endclass