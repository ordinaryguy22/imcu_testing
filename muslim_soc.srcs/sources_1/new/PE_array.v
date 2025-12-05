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


module PE_array  #(parameter DATA_WIDTH = 8,
              parameter NUM_MULTIPLIERS = 384/(3*DATA_WIDTH),
              parameter MAIN_ADDRESS_BITS = $clog2(NUM_MULTIPLIERS * 3),
              parameter IB_ADDRESS_BITS = $clog2(NUM_MULTIPLIERS * 3 / 2)
              )
              (
/*     address_input_buffer,
                             address_main_memory,
                             address_weight_buffer,
                             BL, 
                             BLA, 
                             W_EN, 
                             Read_EN,
                             clk,
                             IMC,
                             EN_IB,
                             EN_W,
                             read,
                             write,
                             mem_out,
                             latch_MC_En,
                             MC*/
                                 input [IB_ADDRESS_BITS-1:0] address_input_buffer,
                                 input [MAIN_ADDRESS_BITS-1:0] address_main_memory,
                                 input clk, IMC,EN_W, read,write,
                                 input [49:0] EN_IB,
                                 input [DATA_WIDTH-1:0] BL, BLA,
                                 input Read_EN,W_EN,
                                 input [4:0] address_weight_buffer,
                                 
                                 output [DATA_WIDTH-1:0]mem_out,
                                 output reg   MC ,
                                 output reg latch_MC_En  
                             

    );
    

        reg [DATA_WIDTH-1:0] MAC_result [49:0];
        
        wire latch_MC_En_internal [49:0];
        wire MC_internal [49:0];
        wire [DATA_WIDTH-1:0] Lq [NUM_MULTIPLIERS-1:0];
        wire [DATA_WIDTH-1:0] highq [NUM_MULTIPLIERS-1:0];
        wire [DATA_WIDTH-1:0] BLB,  stored_value_bar1, stored_value_bar2, out1,out2;
        wire [DATA_WIDTH-1:0] C0L;
        wire [DATA_WIDTH-1:0] WL_SL;
        
        
        
        wire [DATA_WIDTH:0] S [NUM_MULTIPLIERS-1:0];
        wire [DATA_WIDTH:0] S_not [NUM_MULTIPLIERS-1:0];
        wire WL_N;
        wire WL_SH;
        wire rst;
        wire [NUM_MULTIPLIERS-1:0] OUT [49:0]; //A
        wire [(1<<MAIN_ADDRESS_BITS)-1:0] Dout;
        wire [DATA_WIDTH-1:0] OUT_WB;
        assign BLB = ~BL;
        
        wire [(2*DATA_WIDTH)-1:0] m [49:0];
        wire [NUM_MULTIPLIERS-1:0] OUT_IB [49:0];
        wire [DATA_WIDTH-1:0] output_buffer_lsw [49:0]; //lower significant word[32 bits]
        wire [DATA_WIDTH-1:0] output_buffer_msw [49:0]; //Upper significant word[32 bits]
        wire [DATA_WIDTH-1:0] output_port [(1<<MAIN_ADDRESS_BITS)-1:0];
    
    genvar i;
    generate 
    for (i=0;i<50;i=i+1)begin:rows_inst
    PE_Tiles_50 PE_rows(
                         .address_input_buffer(address_input_buffer),
                           .address_main_memory(address_main_memory),
                           .BL(DMA_RData), //weightsssss
                           .BLA(DMA_RData), //inputttttt
                           .clk(clk), //ok
                           .IMC(IMC), //ok
                           .EN_IB(EN_IB),
                           .EN_W(EN_W),
                           .OUT_IB(OUT_IB[i]),
                           .read(read_imcu),
                           .write(write_imcu),
                           .mem_out(imcu_out), 
                           .latch_MC_En(latch_MC_En),
                           .MC(MC),
                           .MAC_result(MAC_result[i])              
            );
       end
       endgenerate
            
  genvar s;
  generate
     for(s=0;s<50;s=s+1) begin: IB_Gen
         INPUT_BUFFER #(.ADDR(IB_ADDRESS_BITS),
                        .DATA_WIDTH(DATA_WIDTH),
                        .X(NUM_MULTIPLIERS))
                        IB1(clk,address_input_buffer, BLA, EN_IB[s],C0L,OUT_IB[s]);
     end
   endgenerate
   
   
   Timing_control #(.DATA_WIDTH(DATA_WIDTH)) TC1(clk, IMC, WL_N, WL_SH, rst, C0L, WL_SL);

   
endmodule
