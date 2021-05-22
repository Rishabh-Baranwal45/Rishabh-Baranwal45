`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:26 12/08/2020 
// Design Name: 
// Module Name:    ID 
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
`include opcode_file.v;

module ID(
input clock, reset, ALU_MEMORY, RIDIR,       // ALU=0, MEMORY=1
input [7:0] opcode,                    // 
output reg [4:0] ALU_opcode,             
output reg [1:0] opcode_length,        
output reg [1:0] operand1,operand2,
output reg [2:0] R, 
output reg SP_PUSH,SP_POP,  
output reg E_SFR);                     //ENABLE CARRY FLAG, ENABLE ZERO FLAG

parameter accumulator=2'd1 ; immediate=2'd2 ; DIR=2'd3 ;

always@(*)
if (reset)
begin ALU_opcode=6'b0; opcode_length=0; end
else
case(opcode)
//ADD with Accumulator
`ADD_A_I              :  begin ALU_opcode=5'b00001; opcode_length=2'd2; operand1= accumulator; operand2= immediate; E_SFR=1'b1; ALU_MEMORY=0; end
`ADD_A_DIR            :  begin ALU_opcode=5'b00001; opcode_length=2'd2; operand1= accumulator; operand2= DIR;       E_SFR=1'b1; ALU_MEMORY=0; end
`ADD_A_RIDIR          :  begin ALU_opcode=5'b00001; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; RIDIR=opcode[0];     E_SFR=1'b1; ALU_MEMORY=0; end
`ADD_A_R              :  begin ALU_opcode=5'b00001; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; R=opcode[2:0];       E_SFR=1'b1; ALU_MEMORY=0; end

//ADD with Accumulator & carry flag
`ADDC_A_I             :  begin ALU_opcode=5'b01000; opcode_length=2'd2; operand1= accumulator; operand2= immediate; E_SFR=1'b1; ALU_MEMORY=0; end
`ADDC_A_DIR           :  begin ALU_opcode=5'b01000; opcode_length=2'd2; operand1= accumulator; operand2= DIR;       E_SFR=1'b1; ALU_MEMORY=0; end
`ADDC_A_RIDIR         :  begin ALU_opcode=5'b01000; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; RIDIR=opcode[0];     E_SFR=1'b1; ALU_MEMORY=0; end
`ADDC_A_R             :  begin ALU_opcode=5'b01000; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; R=opcode[2:0];       E_SFR=1'b1; ALU_MEMORY=0; end  

//Subtract with borrow
`SUBB_A_I             :  begin ALU_opcode=5'b00010; opcode_length=2'd2; operand1= accumulator; operand2= immediate; E_SFR=1'b1; ALU_MEMORY=0; end
`SUBB_A_DIR           :  begin ALU_opcode=5'b00010; opcode_length=2'd2; operand1= accumulator; operand2= DIR;       E_SFR=1'b1; ALU_MEMORY=0; end
`SUBB_A_RIDIR         :  begin ALU_opcode=5'b00010; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; RIDIR=opcode[0];     E_SFR=1'b1; ALU_MEMORY=0; end
`SUBB_A_R             :  begin ALU_opcode=5'b00010; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; R=opcode[2:0];       E_SFR=1'b1; ALU_MEMORY=0; end

//INC and DEC
`INC_A                :  begin ALU_opcode=5'b00011; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; E_SFR=1'b1; ALU_MEMORY=0; end
`INC_DIR              :  begin ALU_opcode=5'b00011; opcode_length=2'd2; operand1= DIR;         operand2= 2'bz; E_SFR=1'b1; ALU_MEMORY=0; end
`INC_RIDIR            :  begin ALU_opcode=5'b00011; opcode_length=2'd1; operand1= 2'bz;        operand2= 2'bz; RIDIR=opcode[0]; E_SFR=1'b1; ALU_MEMORY=0; end
`INC_R                :  begin ALU_opcode=5'b00011; opcode_length=2'd1; operand1= 2'bz;        operand2= 2'bz; R=opcode[2:0]; E_SFR=1'b1; ALU_MEMORY=0; end
//`INC_DPTR             :  begin ALU_opcode=5'b00011; opcode_length=2'd1; operand1= 2'bz;  E_SFR=1'b1; ALU_MEMORY=0; end

`DEC_A                :  begin ALU_opcode=5'b00100; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;  E_SFR=1'b1; ALU_MEMORY=0; end
`DEC_DIR              :  begin ALU_opcode=5'b00011; opcode_length=2'd2; operand1= DIR;         operand2= 2'bz;  E_SFR=1'b1; ALU_MEMORY=0; end
`DEC_RIDIR            :  begin ALU_opcode=5'b00011; opcode_length=2'd1; operand1= 2'bz;        operand2= 2'bz;  RIDIR=opcode[0]; E_SFR=1'b1; ALU_MEMORY=0; end
`DEC_R                :  begin ALU_opcode=5'b00011; opcode_length=2'd1; operand1= 2'bz;        operand2= 2'bz;  R=opcode[2:0]; E_SFR=1'b1; ALU_MEMORY=0; end

//ROTATE
`RR_A                 :  begin ALU_opcode=5'b01110; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;  E_SFR=1'b1; ALU_MEMORY=0; end
`RRC_A                :  begin ALU_opcode=5'b01111; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;  E_SFR=1'b1; ALU_MEMORY=0; end
`RL_A                 :  begin ALU_opcode=5'b01100; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;  E_SFR=1'b1; ALU_MEMORY=0; end
`RLC_A                :  begin ALU_opcode=5'b01101; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;  E_SFR=1'b1; ALU_MEMORY=0; end
`SWAP_A               :  begin ALU_opcode=5'b10010; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;  E_SFR=1'b1; ALU_MEMORY=0; end

//LOGICAL
`ANL_DIR_A            :  begin ALU_opcode=5'b01001; opcode_length=2'd2; operand1= DIR;         operand2= accumulator; E_SFR=1'b1; ALU_MEMORY=0;  end
`ANL_DIR_I            :  begin ALU_opcode=5'b01001; opcode_length=2'd3; operand1= DIR;         operand2= immediate; E_SFR=1'b1; ALU_MEMORY=0;  end
`ANL_A_I              :  begin ALU_opcode=5'b01001; opcode_length=2'd2; operand1= accumulator; operand2= immediate; E_SFR=1'b1; ALU_MEMORY=0;  end
`ANL_A_DIR            :  begin ALU_opcode=5'b01001; opcode_length=2'd2; operand1= accumulator; operand2= DIR;       E_SFR=1'b1; ALU_MEMORY=0;  end
`ANL_A_RIDIR          :  begin ALU_opcode=5'b01001; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;      RIDIR=opcode[0];    E_SFR=1'b1; ALU_MEMORY=0;  end
`ANL_A_R              :  begin ALU_opcode=5'b01001; opcode_length=2'd1; operand1= accumulator; R=opcode[2:0]; E_SFR=1'b1; ALU_MEMORY=0;  end

`ORL_DIR_A            :  begin ALU_opcode=5'b01010; opcode_length=2'd2; operand1= DIR; operand2= immediate;          E_SFR=1'b1; ALU_MEMORY=0; end
`ORL_DIR_I            :  begin ALU_opcode=5'b01010; opcode_length=2'd3; operand1= DIR; operand2= immediate;          E_SFR=1'b1; ALU_MEMORY=0; end
`ORL_A_I              :  begin ALU_opcode=5'b01010; opcode_length=2'd2; operand1= accumulator; operand2= immediate;  E_SFR=1'b1; ALU_MEMORY=0; end
`ORL_A_DIR            :  begin ALU_opcode=5'b01010; opcode_length=2'd2; operand1= accumulator; operand2= DIR;        E_SFR=1'b1; ALU_MEMORY=0; end
`ORL_A_RIDIR          :  begin ALU_opcode=5'b01010; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;  RIDIR=opcode[0];       E_SFR=1'b1; ALU_MEMORY=0; end
`ORL_A_R              :  begin ALU_opcode=5'b01010; opcode_length=2'd1; operand1= accumulator; R=opcode[2:0];  E_SFR=1'b1; ALU_MEMORY=0; end

`XRL_DIR_A            :  begin ALU_opcode=5'b01011; opcode_length=2'd2; operand1= DIR;         operand2= immediate;          E_SFR=1'b1; ALU_MEMORY=0; end
`XRL_DIR_I            :  begin ALU_opcode=5'b01011; opcode_length=2'd3; operand1= DIR;         operand2= immediate;          E_SFR=1'b1; ALU_MEMORY=0; end
`XRL_A_I              :  begin ALU_opcode=5'b01011; opcode_length=2'd2; operand1= accumulator; operand2= immediate;  E_SFR=1'b1; ALU_MEMORY=0; end
`XRL_A_DIR            :  begin ALU_opcode=5'b01011; opcode_length=2'd2; operand1= accumulator; operand2= DIR;        E_SFR=1'b1; ALU_MEMORY=0; end
`XRL_A_RIDIR          :  begin ALU_opcode=5'b01011; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;  RIDIR=opcode[0];      E_SFR=1'b1; ALU_MEMORY=0; end
`XRL_A_R              :  begin ALU_opcode=5'b01011; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz;        R=opcode[2:0];  E_SFR=1'b1; ALU_MEMORY=0; end

//ACCUMULATOR
`MUL_AB               :  begin ALU_opcode=5'b00101; opcode_length=2'd1; operand1= accumulator; operand2= B ; E_SFR=1'b1; E_SFR=1'b1; ALU_MEMORY=0; end           
`DIV_AB               :  begin ALU_opcode=5'b00110; opcode_length=2'd1; operand1= accumulator; operand2= B ; E_SFR=1'b1; E_SFR=1'b1; ALU_MEMORY=0; end
`DA_A                 :  begin ALU_opcode=5'b00111; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; E_SFR=1'b1; E_SFR=1'b1; ALU_MEMORY=0; end
`CLR_A                :  begin ALU_opcode=5'b10000; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; E_SFR=1'b1; E_SFR=1'b1; ALU_MEMORY=0; end
`CPL_A                :  begin ALU_opcode=5'b10001; opcode_length=2'd1; operand1= accumulator; operand2= 2'bz; E_SFR=1'b1; E_SFR=1'b1; ALU_MEMORY=0; end

//PUSH & POP
`PUSH_DIR             :  begin SP_PUSH=1; opcode_length=2'd2; operand1= accumulator; operand2= DIR; ALU_MEMORY=1; end
`POP_DIR              :  begin SP_POP=1;  opcode_length=2'd2; operand1= accumulator; operand2= DIR; ALU_MEMORY=1; end

//EXCHANGE

`XCH_A_DIR            : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=DIR; ALU_MEMORY=1; end
`XCH_A_RIDIR          : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=2'bz; RIDIR=opcode[0]; ALU_MEMORY=1; end
`XCH_A_R              : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2= 2'bz; R=opcode[2:0]; ALU_MEMORY=1; end
//`XCHD_A_RIDIR         : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=memory; ALU_MEMORY=1; end

//MOVE with immediate data
`MOV_A_I              : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=immediate; ALU_MEMORY=1; end
`MOV_DIR_I            : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=immediate; ALU_MEMORY=1; end
`MOV_RIDIR_I          : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=immediate; ALU_MEMORY=1; end
`MOV_R_I              : begin mem_operation=1; opcode_length=2'd2; R=opcode[2:0];        operand2=immediate; ALU_MEMORY=1; end
//`MOV_DPTR_I           : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=immediate; ALU_MEMORY=1; end

//MOVE with direct memory location
`MOV_DIR_DIR          : begin mem_operation=1; opcode_length=2'd3; operand1=DIR;  operand2=DIR;   ALU_MEMORY=1; end
`MOV_DIR_R            : begin mem_operation=1; opcode_length=2'd2; operand1=DIR;  operand2=2'bz;  R=opcode[2:0]; ALU_MEMORY=1; end
`MOV_R_DIR            : begin mem_operation=1; opcode_length=2'd2; operand1=2'bz; operand2= 2'bz; R=opcode[2:0]; operand2=DIR; ALU_MEMORY=1; end

//MOVE with Accumulator
`MOV_A_DIR            : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=DIR; ALU_MEMORY=1; end
`MOV_A_RIDIR          : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=2'bz; RIDIR=opcode[0]; ALU_MEMORY=1; end
`MOV_A_R              : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=2'bz; R=opcode[2:0]; ALU_MEMORY=1; end
`MOV_DIR_A            : begin mem_operation=1; opcode_length=2'd2; operand1=DIR;  operand2=accumulator; ALU_MEMORY=1; end
`MOV_RIDIR_A          : begin mem_operation=1; opcode_length=2'd2; operand1=2'bz; RIDIR=opcode[0]; operand2=accumulator; ALU_MEMORY=1; end
`MOV_R_A              : begin mem_operation=1; opcode_length=2'd2; operand1=2'bz; R=opcode[2:0]; operand2=accumulator; ALU_MEMORY=1; end

//MOVE with external memory
`MOVX_A_DPTR          : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=memory; ALU_MEMORY=1; end
`MOVX_A_RIDIR         : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=memory; ALU_MEMORY=1; end
`MOVX_DPTR_A          : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=memory; ALU_MEMORY=1; end
`MOVX_RIDIR_A         : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=memory; ALU_MEMORY=1; end

//MOVE with code memory
`MOVC_A_PC            : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=memory; ALU_MEMORY=1; end
`MOVC_A_DPTR          : begin mem_operation=1; opcode_length=2'd2; operand1=accumulator; operand2=memory; ALU_MEMORY=1; end
end
endcase
endmodule

/*
//Bit MOVE
`MOV_BIT_C
`MOV_C_BIT

//Indirect MOVE with R0 and R1
`MOV_DIR_RIDIR 
`MOV_RIDIR_DIR 

//No operation
`NOP


    