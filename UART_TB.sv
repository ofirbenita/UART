`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2024 19:36:52
// Design Name: 
// Module Name: UART_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_TB(

    );

  // �������
  parameter DBIT = 8;
  parameter SB_TICK = 16;
  parameter DVSR = 10;      // ��� DVSR ����� ���� �� 9600 �� ���� �� 50MHz
  parameter DVSR_BIT = 13;

  // ����� ���� ���� ���
  logic clk, reset;
  logic tx_start;
  logic [7:0] din;
  logic rx, tx;
  logic tx_done_tick, rx_done_tick;
  logic [7:0] dout;

  // ���� �� ����� �-UART
  uart #(
    .DBIT(DBIT),
    .SB_TICK(SB_TICK),
    .DVSR(DVSR),
    .DVSR_BIT(DVSR_BIT)
  ) uart_inst (
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .din(din),
    .tx_done_tick(tx_done_tick),
    .tx(tx),
    .rx(rx),  // ���� �� �-tx �-rx ��� ����� ����� �����-�����
    .rx_done_tick(rx_done_tick),
    .dout(dout)
  );

  // ����� �����
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // ���� ���� 50MHz (20ns �����)
  end

  // ������ �����
  initial begin
    reset = 1;
    tx_start = 0;
    din = 8'b0;
    #40 reset = 0;   // ����� ����� ���� 40ns
  end

  // ����� ����� ������
  initial begin
    // ��� �� ����� ������
    #100;
    din = 8'hA5;       // ����� ����� ������ (0xA5)
     $display(" Expected data: %h", din);
    tx_start = 1;      // ����� �� ������
    #20 tx_start = 0;  // ����� �� tx_start ���� ����� ���� ���
    
    // ���� ����� ������
    wait(rx_done_tick);  // ���� ������� ������

    // ���� ����� ������
    wait(tx_done_tick==1'b1);  // ���� ����� ������
    
    // ����� �����
    
    
    if (dout == 8'ha5)
      $display("Test Passed! Received data: %h", dout);
    else
      $display("Test Failed! Expected: %h, Received: %h", 8'hA5, dout);

    // ��� �� ����� ����
    #100;
    din = 8'h3C;       // ���� ���� ������ (0x3C)
    $display(" Expected data: %h", din);
    tx_start = 1;
    #80
     tx_start = 0;
     #50
    
    // ���� ����� ������
    wait(rx_done_tick);

    // ���� ����� ������
    wait(tx_done_tick);
    
    // ����� �����
    if (dout == 8'h3C)
      $display("Test Passed! Received data: %h", dout);
    else
      $display("Test Failed! Expected: %h, Received: %h", 8'h3C, dout);

    #100 $stop;  // ���� ���������
  end

endmodule
