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


module controlUnit(
        output IRload,
        output JMPmux,
        output PCload,
        output Meminst,
        output MemWr,
        output [1:0]Asel,
        output Aload,
        output Sub,
        
        input [7:5]IR,
        input Aeqz,
        input Abigz,
        
        input Enter,
        
        output Halt,
        
        input clock,
        input reset
    );
        
    //State variables
    reg [3:0] state = 4'd0;
    wire [3:0]nextstate;
  
    initial begin
        state = 4'b000;
    end
  
    //Next State loop
    always@(posedge clock, negedge reset)
    begin
     if(reset)
         state <= 4'd0;
     else
         state <= nextstate;
    end

    //Next state equations 
    assign nextstate[3] = !state[3] & !state[2] & state[1] & !state[0] | 
                            state[3] & state[2] & !state[1] & !state[0] & !Enter | 
                            state[3] & state[2] & state[1] & state[0];
                            
    assign nextstate[2] = !state[3] & !state[2] & state[1] & !state[0] & IR[7] | 
                            state[3] & state[2] & !state[1] & !state[0] & !Enter | 
                            state[3] & state[2] & state[1] & state[0];
                            
    assign nextstate[1] = !state[3] & !state[2] & !state[1] & state[0] |
                            !state[3] & !state[2] & state[1] & !state[0] & IR[6] | 
                            state[3] & state[2] & state[1] & state[0];
                            
    assign nextstate[0] = !state[3] & !state[2] & !state[1] & !state[0] | 
                            !state[3] & !state[2] & state[1] & !state[0] & IR[5] | 
                            state[3] & state[2] & state[1] & state[0];
    
    //Output equations
    assign IRload  = !state[3] & !state[2] & !state[1] & state[0];
    assign JMPmux  = state[3] & state[2] & !state[1] & state[0] | state[3] & state[2] & state[1] & !state[0];
    assign PCload  = !state[3] & !state[2] & !state[1] & state[0] | state[3] & state[2] & !state[1] & state[0] & Aeqz | state[3] & state[2] & state[1] & !state[0] & Abigz;
    assign Meminst = !state[3] & !state[2] & state[1] & !state[0] | state[3] & !state[2] & !state[1] & state[0] | state[3] & !state[2] & !state[1] & !state[0] | state[3] & !state[2] & !state[1] & state[0] | state[3] & !state[2] & state[1] & !state[0] | state[3] & !state[2] & state[1] & state[0];
    assign MemWr   = state[3] & !state[2] & !state[1] & state[0];
    assign Asel[1] = state[3] & !state[2] & !state[1] & !state[0];
    assign Asel[0] = state[3] & state[2] & !state[1] & !state[0];
    assign Aload   = state[3] & !state[1] & !state[0] | state[3] & !state[2] & state[1];
    assign Sub     = state[3] & !state[2] & state[1] & state[0];
    assign Halt    = state[3] & state[2] & state[1] & state[0];
    
endmodule