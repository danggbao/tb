class generator;
    mailbox gen2agt;
    transaction tr;
    event agent_done;
    int repeat_count = 20;
    function new(mailbox gen2agt, event ev);
        this.gen2agt = gen2agt;
        this.agent_done = ev; = ev;
    endfunction
    task run();
        repeat(repeat_count) begin
            tr = new();
            tr.randomize();
            gen2agt.put(tr);
            @(agent_done);
        end
    endtask
endclass