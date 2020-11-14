`timescale 1ns / 1ps
module sram_io(
    input wire clk,
    input wire rst,
    input wire oen,
    input wire wen,
    input wire[31:0] data_in,
    output reg[31:0] data_out,
    output wire done,
    
    inout wire[31:0] ram_data_wire,
    output wire ram_ce_n,       //RAM片选，低有效
    output wire ram_oe_n,       //RAM读使能，低有效
    output wire ram_we_n        //RAM写使能，低有效
    );
    
    reg data_z;
    assign ram_data_wire = data_z ? 32'bz : data_in;
    
    localparam STATE_IDLE = 3'b000;
    localparam STATE_READ_0 = 3'b001;
    localparam STATE_READ_1 = 3'b010;
    localparam STATE_READ_2 = 3'b011;
    localparam STATE_WRITE_0 = 3'b100;
    localparam STATE_WRITE_1 = 3'b101;
    localparam STATE_WRITE_2 = 3'b110;
    localparam STATE_DONE = 3'b111;
    
    reg[2:0] state;
    assign done = state == STATE_DONE;
    
    reg ram_ce_n_flag;
    reg ram_oe_n_flag;
    reg ram_we_n_flag;

    assign ram_ce_n = ram_ce_n_flag;
    assign ram_oe_n = ram_oe_n_flag;
    assign ram_we_n = ram_we_n_flag;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state = STATE_IDLE;
            ram_ce_n_flag = 1'b1;
            ram_we_n_flag = 1'b1;
            ram_oe_n_flag = 1'b1;
            data_z <= 1'b1;
        end
        else begin
            case (state)
                STATE_IDLE: begin
                    if (~oen) begin
                        data_z <= 1'b1;
                        state <= STATE_READ_0;
                    end
                    else if (~wen) begin
                        data_z <= 1'b0;
                        state <= STATE_WRITE_0;
                    end
                end
                STATE_READ_0: begin
                    state <= STATE_READ_1;
                    ram_oe_n_flag = 1'b0;
                    ram_ce_n_flag = 1'b0;
                end
                STATE_READ_1: begin
                    state <= STATE_DONE;
                    ram_oe_n_flag = 1'b1;
                    ram_ce_n_flag = 1'b1;
                    data_out <= ram_data_wire;
                end
                STATE_WRITE_0: begin
                    state <= STATE_WRITE_1;
                    ram_we_n_flag = 1'b0;
                    ram_ce_n_flag = 1'b0;
                end
                STATE_WRITE_1: begin
                    state <= STATE_DONE;
                    ram_we_n_flag = 1'b1;
                    ram_ce_n_flag = 1'b1;
                end
                STATE_DONE: begin
                    data_z <= 1'b1;
                    if (oen&wen) begin
                        state <= STATE_IDLE;
                    end
                end
            endcase
        end
    end
endmodule
