module if_id(

    input wire                      clk,
    input wire                      rst,
    input wire[5:0]                 stall,

    // if阶段得到的pc和inst
    input wire[`InstAddrBus]        if_pc,
    input wire[`InstBus]            if_inst,
    //准备给id的pc和inst
    output reg[`InstAddrBus]        id_pc,
    output reg[`InstBus]            id_inst
);

    always @ (posedge clk) begin
        if (rst == `RstEnable) begin
            id_pc <= `ZeroWord;
            id_inst <= `ZeroWord;
        end else if(stall[1] == `Stop && stall[2] == `NoStop) begin
            // 取指阶段暂停，译码继续，送一个nop
            id_pc <= `ZeroWord;
            id_inst <= `ZeroWord;
      end else if(stall[1] == `NoStop) begin
            //  取指不暂停，前送
            id_pc <= if_pc;
            id_inst <= if_inst;
        end
    end

endmodule
