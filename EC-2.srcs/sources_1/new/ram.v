`timescale 1ns / 1ps

module ram(
    input reset,
	input clock,
	input WE,
	input [4:0]Address,
	input [7:0]dataIn,
	output reg [7:0]RamOut
	);
	
	
	reg [7:0]RAM[31:0];
	

always@(posedge clock, negedge reset)
    if(reset)
    begin
		RAM[5'b00000] <= 8'b10011111; //In A, 11111
		RAM[5'b00001] <= 8'b01011111; //Add A, 11111
		RAM[5'b00010] <= 8'b01011111; //Add A, 11111
		RAM[5'b00011] <= 8'b11100000; //Halt
		
		RAM[5'b00100] <= 8'b11100000; //Halt
		RAM[5'b00101] <= 8'b00000000;
		RAM[5'b00110] <= 8'b00000000;
		RAM[5'b00111] <= 8'b00000000;
		
		RAM[5'b01000] <= 8'b00000000;
		RAM[5'b01001] <= 8'b00000000;
		RAM[5'b01010] <= 8'b00000000;
		RAM[5'b01011] <= 8'b00000000;
		
		RAM[5'b01100] <= 8'b00000000;
		RAM[5'b01101] <= 8'b00000000;
		RAM[5'b01110] <= 8'b00000000;
		RAM[5'b01111] <= 8'b00000000;
		                           
		RAM[5'b10000] <= 8'b00000000;
		RAM[5'b10001] <= 8'b00000000;
		RAM[5'b10010] <= 8'b00000000;
		RAM[5'b10011] <= 8'b00000000;
		                           
		RAM[5'b10100] <= 8'b00000000;
		RAM[5'b10101] <= 8'b00000000;
		RAM[5'b10110] <= 8'b00000000;
		RAM[5'b10111] <= 8'b00000000;
		
		RAM[5'b11000] <= 8'b00000000;
		RAM[5'b11001] <= 8'b00000000;
		RAM[5'b11010] <= 8'b00000000;
		RAM[5'b11011] <= 8'b00000000;
		                           
		RAM[5'b11100] <= 8'b00000000;
		RAM[5'b11101] <= 8'b00000000;
		RAM[5'b11110] <= 8'b00000000;
		RAM[5'b11111] <= 8'b00000001;
    end
    else 
    begin
        if(WE)
            RAM[Address] <= dataIn;
        else 
            RamOut <= RAM[Address];
    end
    
endmodule 

