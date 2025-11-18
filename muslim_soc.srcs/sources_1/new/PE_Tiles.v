`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2025 11:14:34 AM
// Design Name: 
// Module Name: PE_Tiles
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


module PE_Tiles(

    );
    
genvar i;
generate    
    for(i=0;i<50;i=i+1) begin: PE_Inst
    IMCU IMCU_init (
    .address_input_buffer(address_input_buffer), //ok
    .address_main_memory(address_main_memory[6:0]),
    .BL(DMA_RData),//ok
    .BLA(DMA_RData),//ok
    .clk(clk),//ok
    .IMC(IMC),
    .EN_IB(EN_IB),//ok
    .EN_W(EN_W),//ok
    .read(read_imcu),//ok
    .write(write_imcu),//ok
    .mem_out(imcu_out), 
    .latch_MC_En(latch_MC_En),
    .MC(MC),
    .tree_out_lsw(output_buffer_lsw),// lower 8 bits of output buffer
    .tree_out_msw(output_buffer_msw) // upper 8 bits of output buffer
    );
    end
    endgenerate
    

    
    
endmodule
