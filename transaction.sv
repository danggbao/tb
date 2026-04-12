class transaction;
    // Data input (randomized)
    rand bit [7:0] din;
    rand bit en;

    // Data output (để lưu trữ kết quả đầu ra chờ so sánh)
    bit [7:0] dout;

    // Có thể thêm các constraints vào đây
    // constraint c_din { din > 0; din < 100; }
endclass
