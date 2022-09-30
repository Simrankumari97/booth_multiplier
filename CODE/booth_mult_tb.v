`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2022 21:37:43
// Design Name: 
// Module Name: booth_mult_tb
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


module booth_mult_tb();
 wire signed [15:0] out;
 reg signed[7:0] a,b;
 booth_mult dut(.A(a),.B(b),.C(out));
 initial
 begin
  a=8'b10011001;
  b=8'b00111001;
  #10
   a=8'b01111100;
  b=8'b00110010;
  
  
  
 #10
  a=8'b11000100;
  b=8'b11111100;
  #10
  a=8'b11111010;
  b=8'b11110011;
  #50
  $stop;
  end
 endmodule
