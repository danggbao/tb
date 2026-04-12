`include "transaction.sv"
`include "generator.sv"
`include "agt.sv"
`include "drv.sv"
`include "monitor.sv"
`include "scb.sv"
`include "checker.sv"
`include "env.sv"

module tb_top;
    // Khai báo clock và reset
    bit clk;
    bit rst;

    // Khởi tạo dao động clock
    always #5 clk = ~clk;

    // Khởi tạo Interface
    intf inf(clk, rst);

    // Điểm kết nối DUT (Device Under Test)
    // dut_module DUT (
    //     .clk(inf.clk),
    //     .rst(inf.rst),
    //     .din(inf.din),
    //     .dout(inf.dout)   
    // );

    // Khai báo Environment
    environment env;

    initial begin
        // Khởi tạo tín hiệu ban đầu
        clk = 0;
        rst = 1;

        // Reset hệ thống một chút trước khi chạy
        #10 rst = 0;
        
        // Cấp phát môi trường và gán virtual interface
        env = new(inf);

        // Bắt đầu chạy testbench
        env.run();

        // Giới hạn thời gian chạy test tránh chạy vĩnh viễn (forever loops)
        #1000;
        $display("======= KET THUC TESTBENCH =======");
        $finish;
    end

    // Dump waveform (tuỳ chọn)
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_top);
    end
endmodule
