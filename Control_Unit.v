`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:13:25 12/15/2020 
// Design Name: 
// Module Name:    Control_Unit 
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
module Control_Unit(
input reset,clock,
input [15:0] PC,
input [7:0] psw_out,
input [4:0] ALU_opcode,
input [1:0] opcode_length,        
input [1:0] operand1,operand2,
input [2:0] R, 
input SP_PUSH,SP_POP, ALU_MEMORY, RIDIR,     // ALU=0, MEMORY=1
input E_SFR,
input [7:0] RAM_DATABUS,ROM_DATABUS,
output reg [1:0] PC_inc,
output reg E_accumulator, rw_accumulator,E_ROM, rw_ROM,E_RAM,rw_ram, rw_reg,
output reg [7:0] ALU_opcode_in,
output reg [2:0] E_reg,
output reg [1:0] E_reg_bank,
output reg [15:0] ROM_ADDRESS,
output reg [7:0] RAM_ADDRESS,
output reg reset_ram,reset_ALU, E_ALU, reset_PC,
output reg [7:0] operand_1, operand_2 );

parameter accumulator=2'd1 , immediate=2'd2 , DIR=2'd3, B=2'd0;
reg [7:0] temp;

 //ALU3 alu (.operand1(operand_1), .operand2(operand_2), .E(E_ALU));
// accumulator_2 (.rw(rw),
always@(posedge clock) begin
if(reset) begin
reset_ram=1; reset_ALU=1; reset_PC;
end
else 
case(ALU_MEMORY)
1'b0 : begin E_ALU=1; ALU_opcode_in= ALU_opcode;
                      if(operand1==accumulator)     begin  E_accumulator=1; rw_accumulator=1; end
                      else if(operand1==immediate)    begin E_ROM=1; ROM_ADDRESS=PC; rw_ROM=1; end
                     // else if(operand1==DIR)          begin E_reg=R; E_reg_bank=psw_out[4:3]; E_RAM=1; rw_ram=1; RAM_ADDRESS= RAM_DATABUS; end
							// else if(RIDIR==1)               begin E_RIDIR=1; 
                      else if(operand1==R)            begin E_reg=R; E_reg_bank=psw_out[4:3]; end
  
                      if(operand2==accumulator)      E_accumulator=1;
                      else if(operand2==immediate)   begin E_ROM=1; ROM_ADDRESS=PC; rw_ROM=1; end
                     // else if(operand2==DIR)         begin E
                      //else if(operand2==RIDIR)        begin 
                      else if(operand2==R)            begin E_reg=R; E_reg_bank=psw_out[4:3]; end
			end				

1'b1 : begin E_ALU=0; 
                       if(operand1==accumulator)      begin E_accumulator=1; rw_accumulator=0;    end
                       else if(operand1==immediate)   begin E_ROM=1; ROM_ADDRESS=PC; rw_ROM=0; end
                       else if(operand1==R)            begin E_reg=R; E_reg_bank=psw_out[4:3]; end
                         
							  if(operand2==accumulator)      begin E_accumulator=1; rw_accumulator=1; end
                      else if(operand2==immediate)   begin E_ROM=1; ROM_ADDRESS=PC; rw_ROM=1; end 
		 end
endcase

case(opcode_length)
opcode_length  : PC_inc= opcode_length;
default        : PC_inc=0;
endcase 
end
endmodule 