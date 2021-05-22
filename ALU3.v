`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:19:15 09/22/2020 
// Design Name: 
// Module Name:    ALU3 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module ALU3(input [7:0] Operand1,Operand2,
input E,
input [7:0] opcode,
input [7:0] in_psw,
output [7:0] Out, 
output [7:0] out_psw);
parameter ADD= 8'b00000001, SUBB= 8'b00000010, INC= 8'b00000011, DEC= 8'b00000100, MUL= 8'b00000101, DIV= 8'b00000110, DA= 8'b00000111, ADC= 8'b00001000;
parameter AND= 8'b00001001, OR= 8'b00001010, XOR= 8'b00001011, RLA= 8'b00001100, RLCA= 8'b00001101, RRA= 8'b00001110, RRCA= 8'b00001111, CLRA= 8'b00010000, CPLA= 8'b00010001, SWAPA= 8'b00010010; 

wire in_cy, in_ac, in_f0, in_rs1, in_rs0,in_ov,in_nc, in_p;
assign {in_cy, in_ac, in_f0, in_rs1, in_rs0,in_ov,in_nc, in_p}= in_psw;
wire CY,AC,F0,RS1,RS0,OV,NC,P;

reg CarryOut;
reg [7:0] Out_ALU;
reg [7:0] B;
reg [7:0] temp;

always @(*) 
begin
case(opcode)
  ADD   : {CarryOut,Out_ALU} = Operand1 + Operand2; 
  INC   : Out_ALU = Operand1 + 8'h01;
  DEC   : Out_ALU = Operand1 - 8'h01; 
  MUL   : begin {CarryOut,Out_ALU} = Operand1 * Operand2; if(CarryOut==1) begin {B,Out_ALU}= Operand1 * Operand2; CarryOut=1'b1; end end
  //DIV   : case(Operand2) 8'b00: begin CarryOut=1'b1; Out_ALU=8'bzz; end default: begin Out_ALU=(Operand1 / Operand2); B=(Operand1 % Operand2); end endcase end
  //DIV  : begin Out_ALU = (Operand2 == 8'h00)?8'bzz:(Operand1 / Operand2); B= (Operand2 != 8'h00)?(Operand1 % Operand2):8'bzz;  CarryOut= (Operand2 == 8'h00)?(1'b1):1'b0;end 
  DA    : begin temp= Operand1;  if((in_ac==1)||(temp[3:0] > 4'h9 )) Out_ALU= Operand1+8'h06; else if(( in_cy==1)||( temp[7:4] > 4'h9)) Out_ALU= Operand1 + 8'h60; end
  ADC   : {CarryOut, Out_ALU}= Operand1 + Operand2 + in_cy;  
  AND   : Out_ALU = Operand1 & Operand2;
  OR    : Out_ALU = Operand1 | Operand2;
  SUBB  : begin Out_ALU = Operand1 - Operand2; CarryOut = !Out_ALU[7]; end
  XOR   : Out_ALU = Operand1 ^ Operand2;
  RLA   : begin temp= Operand1; Out_ALU = ( ( Operand1 << 1 ) | ( temp >> 7 ) ) ; end
  RLCA  : begin temp= Operand1; Out_ALU= {Operand1,in_cy }; CarryOut=temp[7]; end
  RRA   : begin temp= Operand1; Out_ALU = ( ( Operand1 >> 1 ) | ( temp << 7 ) ) ; end
  RRCA  : begin temp= Operand1; Out_ALU= ({ in_cy, Operand1} >>1); CarryOut=temp[0]; end
  CLRA  : Out_ALU= 8'b0;
  CPLA  : Out_ALU= ~Operand1;
  SWAPA : begin temp=Operand1; Out_ALU=(Operand1 << 4)|(temp >> 4) ; end 
default : Out_ALU = Operand1;
endcase 
end

assign CY = (ADD || ADC || SUBB || MUL || RLCA || RRCA)?CarryOut:'bz;
// assign AC = (ADD||ADC||SUBB)?:'bz;
 assign OV =(ADD||ADC||SUBB)?((Operand1[7] & Operand2[7] & ~CarryOut)| (~Operand1[7] & ~Operand2[7] & CarryOut)):1'b0;
 assign P = Out_ALU[7]+Out_ALU[6]+Out_ALU[5]+Out_ALU[4]+Out_ALU[3]+Out_ALU[2]+Out_ALU[1]+Out_ALU[0];
 assign out_psw = {CY,AC,F0,RS1,RS0,OV,NC,P};
assign Out = Out_ALU;
endmodule
