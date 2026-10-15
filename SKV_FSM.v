`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2026 11:45:03
// Design Name: 
// Module Name: SKV_FSM
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


module SKV_FSM(
    input clk, rst_n, din,
    output reg unlock,
    output reg [1:0] next_state,
    output reg [1:0] current_state
    );
    reg c;
    
    always @(posedge clk)
    begin
        if(!rst_n) begin
            current_state <= 2'b00;
            next_state <= 2'b00;
            unlock <= 1'b0;
        end
        else begin
            c = current_state[1] & din;
            next_state[0] = c | ((~current_state[1])&(~current_state[0])&din);
            next_state[1] = c | ((~current_state[1])&(current_state[0])&(~din));
            current_state <= next_state;
            if(current_state == 2'b11 && din == 1'b1) begin
                unlock <= 1'b1;
                end
            else unlock <= 1'b0;
        end
    end
endmodule
