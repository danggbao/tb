interface intf(input logic clk, input logic rst);
    // Khai báo các bus tín hiệu giữa Testbench và DUT ở đây
    logic [7:0] din;
    logic [7:0] dout;
    logic en;
    logic valid_out;
endinterface
