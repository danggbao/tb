class iq_filter_model;
    // Tham số cấu hình (tùy chỉnh theo thiết kế của bạn)
    parameter IQ_DATA_WIDTH = 16;
    parameter CSI_FUZZER_WIDTH = 8;

    // Lưu trữ trạng thái (Registers)
    logic signed [IQ_DATA_WIDTH-1:0] i1, i2, q1, q2;
    logic signed [CSI_FUZZER_WIDTH+IQ_DATA_WIDTH-1:0] tap1_result_i, tap1_result_q;
    logic signed [CSI_FUZZER_WIDTH+IQ_DATA_WIDTH-1:0] tap2_result_i, tap2_result_q;

    function new();
        // Reset các giá trị ban đầu
        i1 = 0; i2 = 0; q1 = 0; q2 = 0;
        tap1_result_i = 0; tap1_result_q = 0;
        tap2_result_i = 0; tap2_result_q = 0;
    endfunction

    // Hàm thực hiện tính toán cho 1 chu kỳ máy
    function logic [2*IQ_DATA_WIDTH-1:0] process_iq(
        input logic signed [IQ_DATA_WIDTH-1:0] i0,
        input logic signed [IQ_DATA_WIDTH-1:0] q0,
        input logic signed [CSI_FUZZER_WIDTH-1:0] bb_gain1,
        input logic signed [CSI_FUZZER_WIDTH-1:0] bb_gain2,
        input logic bb_gain1_rot90_flag,
        input logic bb_gain2_rot90_flag
    );
        logic signed [IQ_DATA_WIDTH-1:0] out_i, out_q;
        logic [2*IQ_DATA_WIDTH-1:0] iq_out;

        // 1. Tính toán Output dựa trên giá trị hiện tại (giống logic <=)
        // Phần bit-slicing [(...-1):CSI_FUZZER_WIDTH] tương đương với việc dịch phải 
        out_i = i0 + (tap1_result_i >>> CSI_FUZZER_WIDTH) + (tap2_result_i >>> CSI_FUZZER_WIDTH);
        out_q = q0 + (tap1_result_q >>> CSI_FUZZER_WIDTH) + (tap2_result_q >>> CSI_FUZZER_WIDTH);
        
        iq_out = {out_q, out_i};

        // 2. Cập nhật các Tap Result cho chu kỳ sau
        tap1_result_i = (bb_gain1_rot90_flag == 0) ? (i1 * bb_gain1) : (-q1 * bb_gain1);
        tap1_result_q = (bb_gain1_rot90_flag == 0) ? (q1 * bb_gain1) : ( i1 * bb_gain1);

        tap2_result_i = (bb_gain2_rot90_flag == 0) ? (i2 * bb_gain2) : (-q2 * bb_gain2);
        tap2_result_q = (bb_gain2_rot90_flag == 0) ? (q2 * bb_gain2) : ( i2 * bb_gain2);

        // 3. Dịch chuyển hàng đợi (Shift registers)
        i2 = i1; q2 = q1;
        i1 = i0; q1 = q0;

        return iq_out;
    endfunction
endclass