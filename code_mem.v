`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:04 09/30/2020 
// Design Name: 
// Module Name:    code_mem 
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
module code_mem(
input clock,
input rw,
input [15:0] add_bus,
inout [7:0] data_bus
);

reg [7:0] cod_mem [8191:0];              // 8 KB memory

assign data_bus=(rw== 1'b1)?cod_mem[add_bus]:'bz; 
always@(posedge clock)
if(rw==1'b0)
cod_mem[add_bus] <= data_bus;
endmodule











