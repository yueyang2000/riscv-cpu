module ctrl(
    input wire                   rst,
    // 来自译码阶段的暂停请求
    input wire                   stallreq_from_id,
    output reg[5:0]              stall

);

// 目前来看只有id阶段需要请求暂停，为了等load
    always @ (*) begin
        if(rst == `RstEnable) begin
            stall <= 6'b000000;
        end else if(stallreq_from_id == `Stop) begin
            stall <= 6'b000111;
        end else begin
            stall <= 6'b000000;
        end    //if
    end
endmodule
