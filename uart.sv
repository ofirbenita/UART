`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2024 19:30:24
// Design Name: 
// Module Name: uart
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


module uart
#(
    parameter DBIT = 8,         // # data bits
    parameter SB_TICK = 16,     // # ticks for stop bits
    parameter DVSR = 10,      // Divisor ל-Baud Rate (למשל עבור 9600bps עם שעון 50MHz)
    parameter DVSR_BIT = 13     // מספר הביטים עבור ה-Divisor
  )
  (
    input  logic clk, reset,
    input  logic tx_start,        // שדר התחלה
    input  logic [7:0] din,       // נתוני קלט לשידור
    output logic tx_done_tick,     // שדר סיום
    output logic tx,               // שדר נתונים
    input  logic rx,               // קליטת נתונים
    output logic rx_done_tick,     // קליטת סיום
    output logic [7:0] dout        // נתוני פלט מהקליטה
  );

  // מודול Baud Rate
  logic baud_tick;
  baud_rate #(.dvsr(DVSR) )  baud_gen_inst (
    .clk(clk),
    .reset(reset),
    .tick(baud_tick)
  );

  // מודול TX (שידור)
  logic [7:0] tx_data;
  tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) tx_inst (
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .s_tick(baud_tick),
    .din(din),
    .tx_done_tick(tx_done_tick),
    .tx(tx)
  );

  // מודול RX (קליטה)
  rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) rx_inst (
    .clk(clk),
    .reset(reset),
    .rx(tx),
    .s_tick(baud_tick),
    .rx_done_tick(rx_done_tick),
    .dout(dout)
  );

endmodule
