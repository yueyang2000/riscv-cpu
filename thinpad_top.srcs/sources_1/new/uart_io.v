`timescale 1ns / 1ps
module uart_io(
    input wire clk,
    input wire rst,
    input wire oen,
    input wire wen,
    input wire[7:0] data_in,
    output reg[7:0] data_out,
    output wire done,
    
    inout wire[31:0] base_ram_data_wire,
    
    output reg uart_rdn,
    output reg uart_wrn,
    input wire uart_dataready,
    input wire uart_tbre,
    input wire uart_tsre
    );
    
    reg[7:0] ram_data;
    reg data_z;
    assign base_ram_data_wire = data_z ? 32'bz : { 24'h000000, ram_data};
    
    localparam STATE_IDLE = 3'b000;
    localparam STATE_READ_0 = 3'b001;
    localparam STATE_READ_1 = 3'b010;
    localparam STATE_WRITE_0 = 3'b011;
    localparam STATE_WRITE_1 = 3'b100;
    localparam STATE_WRITE_2 = 3'b101;
    localparam STATE_WRITE_3 = 3'b110;
    localparam STATE_DONE = 3'b111;
    
    reg[2:0] state;
    assign done = state == STATE_DONE;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            { uart_rdn, uart_wrn } <= 2'b11;
            data_z <= 1'b1;
            state <= STATE_IDLE;
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
                        ram_data <= data_in;
                        state <= STATE_WRITE_0;
                    end
                end
                STATE_READ_0: begin
                    if (uart_dataready) begin
                        uart_rdn <= 1'b0;
                        state <= STATE_READ_1;
                    end 
                end
                STATE_READ_1: begin
                    data_out <= base_ram_data_wire[7:0];
                    uart_rdn <= 1'b1;
                    state <= STATE_DONE;
                end
                STATE_WRITE_0: begin
                    uart_wrn <= 1'b0;
                    state <= STATE_WRITE_1;
                end
                STATE_WRITE_1: begin
                    uart_wrn <= 1'b1;
                    state <= STATE_WRITE_2;
                end
                STATE_WRITE_2: begin
                    if (uart_tbre)
                        state <= STATE_WRITE_3;
                end
                STATE_WRITE_3: begin
                    if (uart_tsre)
                        state <= STATE_DONE;
                end
                STATE_DONE: begin
                    data_z <= 1'b1;
                    if (oen&wen) begin
                        state <= STATE_IDLE;
                        { uart_rdn, uart_wrn } <= 2'b11;
                    end
                end
            endcase
        end
    end
endmodule
