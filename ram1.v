`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:42 04/01/2021 
// Design Name: 
// Module Name:    ram1 
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
module ram1(
 input clock,reset,rd_ram,wr_ram,
 input [7:0] ram_addr, data_in_ram, 
 output [7:0] data_out_ram );

integer i;
reg [7:0] mem [255:0];

initial
begin
for( i=0; i<256; i=i+1)
mem[i]=0;
end

assign data_out_ram= (rd_ram)? (mem[ram_addr]):8'bz;

always@(posedge clock)
begin
if (reset)
begin 
for( i=0; i<256; i=i+1)
mem[i]=0;
end
else if(wr_ram)
mem[ram_addr]=data_in_ram;
end


endmodule
