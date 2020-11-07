`include "defines.vh"

module data_loader(
    input wire[3:0] ram_be_n,
    input wire[1:0] mem_use,
    input wire[`DataBus] data_base_out,
    input wire[`DataBus] data_ext_out,
    output reg[`DataBus] data_to_load
);

wire[`DataBus] data = (mem_use == `USE_BASE)? data_base_out:data_ext_out;
reg sign;
wire ext = sign ? 24'hffffff : 24'h0;
always @(*)begin
    sign <= 0;
    data_to_load <= 32'b0;
    if (mem_use == `USE_UART)
        data_to_load <= 32'b0;
    else begin
        case(ram_be_n)
            `BE_WORD:
                data_to_load <= data;
            `BE_BYTE_0: begin
                sign <= data[7];
                data_to_load <= {ext, data[7:0]};
            end
            `BE_BYTE_1: begin
                sign <= data[15];
                data_to_load <= {ext, data[15:8]};
            end
            `BE_BYTE_2: begin
                sign <= data[23];
                data_to_load <= {ext, data[23:16]};
            end
            `BE_BYTE_3: begin
                sign <= data[31];
                data_to_load <= {ext, data[31:24]};
            end
        endcase
    end
end

endmodule