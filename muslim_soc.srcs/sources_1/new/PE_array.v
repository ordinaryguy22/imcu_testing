`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2025 04:54:09 PM
// Design Name: 
// Module Name: PE_array
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


module PE_array(
    

    );
    
    PE_Tiles_50 PE_rows(
                         .address_input_buffer(address_input_buffer),
                           .address_main_memory(address_main_memory),
                           .BL(DMA_RData), //weightsssss
                           .BLA(DMA_RData), //inputttttt
                           .clk(clk),
                           .IMC(IMC),
                           .EN_IB(EN_IB),
                           .EN_W(EN_W),
                           .read(read_imcu),
                           .write(write_imcu),
                           .mem_out(imcu_out), 
                           .latch_MC_En(latch_MC_En),
                           .MC(MC),
                           .MAC_result(MAC_Result)              
            );
endmodule
