`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:40 12/05/2020 
// Design Name: 
// Module Name:    accumulator_2 
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
module accumulator_2(
 input clock, rw,        // read=1, write=0
 input [7:0] bit_add,
 inout [7:0] data_bus
 );

 bit_memo b1(.clock(clock), .wr(rw), .E(bit_add[0]), .data(data_bus[0])); 
 bit_memo b2(.clock(clock), .wr(rw), .E(bit_add[1]), .data(data_bus[1])); 
 bit_memo b3(.clock(clock), .wr(rw), .E(bit_add[2]), .data(data_bus[2]));
 bit_memo b4(.clock(clock), .wr(rw), .E(bit_add[3]), .data(data_bus[3]));
 bit_memo b5(.clock(clock), .wr(rw), .E(bit_add[4]), .data(data_bus[4]));
 bit_memo b6(.clock(clock), .wr(rw), .E(bit_add[5]), .data(data_bus[5]));
 bit_memo b7(.clock(clock), .wr(rw), .E(bit_add[6]), .data(data_bus[6]));
 bit_memo b8(.clock(clock), .wr(rw), .E(bit_add[7]), .data(data_bus[7]));
   
endmodule
