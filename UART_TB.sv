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

  // פרמטרים
  parameter DBIT = 8;
  parameter SB_TICK = 16;
  parameter DVSR = 10;      // ערך DVSR לבאוד רייט של 9600 עם שעון של 50MHz
  parameter DVSR_BIT = 13;

  // אותות עבור הטסט בנץ
  logic clk, reset;
  logic tx_start;
  logic [7:0] din;
  logic rx, tx;
  logic tx_done_tick, rx_done_tick;
  logic [7:0] dout;

  // מופע של מודול ה-UART
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
    .rx(rx),  // מחבר את ה-tx ל-rx כדי לדמות לולאת שידור-קליטה
    .rx_done_tick(rx_done_tick),
    .dout(dout)
  );

  // מחולל השעון
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // יוצר שעון 50MHz (20ns מחזור)
  end

  // הגדרות אתחול
  initial begin
    reset = 1;
    tx_start = 0;
    din = 8'b0;
    #40 reset = 0;   // שחרור אתחול אחרי 40ns
  end

  // בדיקת שידור וקליטה
  initial begin
    // שלח את המידע הראשון
    #100;
    din = 8'hA5;       // דוגמה לנתון לשידור (0xA5)
     $display(" Expected data: %h", din);
    tx_start = 1;      // מפעיל את השידור
    #20 tx_start = 0;  // משחרר את tx_start אחרי מחזור שעון אחד
    
    // המתן לסיום השידור
    wait(rx_done_tick);  // מחכה שהשידור יסתיים

    // המתן לסיום הקליטה
    wait(tx_done_tick==1'b1);  // מחכה לסיום הקליטה
    
    // בדיקת תוצאה
    
    
    if (dout == 8'ha5)
      $display("Test Passed! Received data: %h", dout);
    else
      $display("Test Failed! Expected: %h, Received: %h", 8'hA5, dout);

    // שלח את המידע השני
    #100;
    din = 8'h3C;       // נתון נוסף לשידור (0x3C)
    $display(" Expected data: %h", din);
    tx_start = 1;
    #80
     tx_start = 0;
     #50
    
    // המתן לסיום השידור
    wait(rx_done_tick);

    // המתן לסיום הקליטה
    wait(tx_done_tick);
    
    // בדיקת תוצאה
    if (dout == 8'h3C)
      $display("Test Passed! Received data: %h", dout);
    else
      $display("Test Failed! Expected: %h, Received: %h", 8'h3C, dout);

    #100 $stop;  // סיום הסימולציה
  end

endmodule
