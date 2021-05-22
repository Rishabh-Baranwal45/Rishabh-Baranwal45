`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:40:03 01/31/2021 
// Design Name: 
// Module Name:    Stack_Pointer 
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
module Stack_Pointer(
input reset, push,pop,clock, rd_sp, wr_sp,
input [7:0] data_in_sp,
output [7:0] data_out_SP
);

reg [7:0] stack_mem;
initial begin stack_mem=8'h07; end 

assign data_out_SP= (rd_sp)?stack_mem:8'bz;

always@(clock) begin
if (reset) stack_mem = 8'h07;
else if(push) begin if(stack_mem < 8'h7f) stack_mem = stack_mem+1;
                    else stack_mem = 8'h00; end
						  //data_out_SP=stack_mem; end
else if (pop) begin stack_mem = stack_mem-1;  end
else if(wr_sp) begin stack_mem= data_in_sp; end
end
endmodule
