`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2025 12:30:51 AM
// Design Name: 
// Module Name: INPUT_BUFFER
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

module WEIGHT_BUFFER #(parameter ADDR = 5,parameter DATA_WIDTH = 8,
                  
                      parameter X=16)
                      (clk,Address, BL , OUT, Read_EN,W_EN); // EN IS AN INPUT TOO
input [ADDR-1:0] Address;
input [DATA_WIDTH-1:0] BL;
input clk;
input Read_EN;
input W_EN;
output reg [DATA_WIDTH-1:0] OUT;


wire [X-1 :0] DOUT ;


reg [DATA_WIDTH-1 :0] weight_data [X-1:0]  ;
reg [DATA_WIDTH-1:0] BL_reg;

/*integer i;
initial begin
for(i =0;i<16;i=i+1) begin
weight_data[i]<=0;
end*/

//end

always@(posedge clk)begin
BL_reg <= BL;
if(W_EN) begin
weight_data[Address] <= BL_reg;
end

else if (Read_EN) 
OUT<=weight_data[Address];

else begin
OUT<=8'b0;
end

end


endmodule
