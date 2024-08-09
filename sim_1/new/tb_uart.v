`timescale 1ns / 1ps

module tb_uart();
    reg clk;
    reg reset;
    reg startSignal;
    reg [7:0] tx_data;
    wire tx_done;
    wire txd;

    top_uart dut_top_uart(
    .clk(clk),
    .reset(reset),
    .start(startSignal),
    .tx_data(tx_data),
    .o_txd(txd),
    .o_done(tx_done)
    );

    // gen clk
    always #5 clk = ~clk; // clk period = 10ns

    initial begin
        #00 clk = 0; reset = 1; 
        startSignal = 0; tx_data=0;
        #10 reset = 0;
        #10 tx_data=8'b10100011; startSignal = 1;
        #10 startSignal = 0;
        // tx_done�� ��¿������� block���°� �ȴ�.(�����Ѵٴ� �ǹ�)
        @(posedge tx_done); // done�� �ö����� ��ٸ���
        #10 tx_data=8'b10100011; startSignal = 1;
        #10 startSignal = 0;
        @(posedge tx_done); // done�� �ö����� ��ٸ���
        #10 tx_data=8'b10101111; startSignal = 1;
        #10 startSignal = 0;
        @(posedge tx_done); // done�� �ö����� ��ٸ���
        #10 $finish;
    end
endmodule
