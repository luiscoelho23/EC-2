`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 11:01:07 PM
// Design Name: 
// Module Name: processor
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

module processor(Clock, Reset, Button, Input, Output, Halt);
    
    input Clock,Reset;
    
    input [7:0]Input;
	output wire [7:0]Output;
 
    input Button;
    
    output wire Halt;
    
    wire [7:0]IR;
    wire [1:0]Asel;
    wire IRload,INmux,JMPmux,PCload, Meminst, MemWr, Aload, Aeqz;
    
    oneshot os(Enter, Clock, Button, Reset);
    
    controlUnit cu(IRload, JMPmux, PCload, Meminst, MemWr, Asel, Aload, Sub, IR[7:5], Aeqz, Abigz, Enter, Halt, Clock, Reset);
			
	datapath dp(IRload, JMPmux, PCload, Meminst, MemWr, Asel, Aload, Sub, Input, IR, Aeqz, Abigz, Output, Clock, Reset);
	
endmodule
