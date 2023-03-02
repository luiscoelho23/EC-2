`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2022 01:21:20
// Design Name: 
// Module Name: datapath
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


module datapath(
        input IRload,
        input JMPmux,
        input PCload,
        input Meminst,
        input MemWr,
        input [1:0]Asel,
        input Aload,
        input Sub,
        input[7:0]Input,
        
        output [7:0]IR,
        output Aeqz,
        output Abigz,
        
        output [7:0]Output,
        
        input Clock,
        input Reset
    );    
    
wire [7:0] Ain;
wire [7:0] RamOut;    
wire [7:0] AddSubOut;
wire [4:0] Address;
wire [4:0] IncWr;
wire [4:0] PCout;
wire [4:0] PCin;

//Memory
ram RAM (Reset, Clock, MemWr, Address, Output, RamOut);  

//Registers
register_master #(.size(8))R_IR (.load(IRload),.reset(Reset),.clock(Clock),.dataIn(RamOut),.dataOut(IR));
register_master #(.size(5))R_PC (.load(PCload),.reset(Reset),.clock(Clock),.dataIn(PCin),.dataOut(PCout));
register_master #(.size(8))R_A  (.load(Aload) ,.reset(Reset),.clock(Clock),.dataIn(Ain),.dataOut(Output));

//---------------------Instruction Set Operations-------------------------------
//A Sel Mux        
assign Ain = Asel[1] ? (Asel[0] ? 8'b00000000 : RamOut) : (Asel[0] ? Input : AddSubOut);

//Add/Subtract
assign AddSubOut = Sub ? (Output - RamOut) : (Output + RamOut);

//A equal zero 
nor(Aeqz,Output);

//A bigger than zero
not(Abigz,Output[7]);    

//---------------------Instruction Set Operations------------------------------
//JMP Mux
assign PCin = JMPmux ? IR[4:0] : IncWr;

//Meminst
assign Address = Meminst ? IR[4:0] : PCout;

//5-bit increment
assign IncWr = PCout + 5'b00001;

endmodule