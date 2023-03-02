`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2022 01:41:47
// Design Name: 
// Module Name: processor_tb
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


module processor_tb();

    reg clock, reset;
    reg [7:0]Input;
    reg Button;
    wire [7:0]Output;
    wire Halt;
    
    initial
	begin
	
	 clock <= 0;
	 reset <= 0;
	 #2 reset = 1;
	 #3 reset = 0;
	 Button <= 1'b0;
	 Input <= 8'd4;
	 
	 clock = ~clock;
	 #2
	 
	 clock = ~clock;
	 #2
	 
	 clock= ~clock;
	 #2
	 
	 clock = ~clock;
	 #2
	 
	 clock = ~clock;
	 #2
	 
	 clock= ~clock;
	 #2
	 
	 Button = 0;
	 
	 clock = ~clock;
	 #2
	 
	 clock = ~clock;
	 #2
	 
	 clock= ~clock;
	 #2
	 
	 Button = 1;
	 
	 clock = ~clock;
	 #2
	 
	 clock= ~clock;
	 #2
	 
	 clock = ~clock;
	 #2
	 
	 clock= ~clock;
	 #2
	 
	 clock= ~clock;
	 
	 Button = 0;
	 
	 forever #2 clock = ~clock;
	end
    
    processor p0 (clock,reset,Button, Input,Output,Halt);
    
endmodule
