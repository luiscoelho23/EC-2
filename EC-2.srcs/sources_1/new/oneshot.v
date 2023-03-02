`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
 
// Create Date: 17.11.2022 02:55:28
// Design Name: 
// Module Name: oneshot
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
 
// Dependencies: 
 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
 
////////////////////////////////////////////////////////////////////////////////


module oneshot(
    output Enter,
    
    input Clock,
    input Button,
    input Reset
    );
    
    wire andOut;
    wire flipFlop1out;
    
    register_master #(.size(1))flipFlop1 (.load(1'b1),.reset(Reset),.clock(Clock),.dataIn(Button),.dataOut(flipFlop1out));
    register_master #(.size(1))flipFlop2  (.load(1'b1) ,.reset(Reset),.clock(Clock),.dataIn(andOut),.dataOut(Enter));
    
    and(andOut, Button, ~flipFlop1out);
   
    
endmodule
