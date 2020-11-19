`timescale 1ns / 1ps
//
// WIDTH: bits in register hdata & vdata
// HSIZE: horizontal size of visible field 
// HFP: horizontal front of pulse
// HSP: horizontal stop of pulse
// HMAX: horizontal max size of value
// VSIZE: vertical size of visible field 
// VFP: vertical front of pulse
// VSP: vertical stop of pulse
// VMAX: vertical max size of value
// HSPP: horizontal synchro pulse polarity (0 - negative, 1 - positive)
// VSPP: vertical synchro pulse polarity (0 - negative, 1 - positive)
//
module vga
#(parameter WIDTH = 0, HSIZE = 0, HFP = 0, HSP = 0, HMAX = 0, VSIZE = 0, VFP = 0, VSP = 0, VMAX = 0, HSPP = 0, VSPP = 0)
(
    input wire rst,
    input wire clk,
    output wire hsync,
    output wire vsync,
    output reg [WIDTH - 1:0] hdata,
    output reg [WIDTH - 1:0] vdata,
    output reg[18:0] addr,
    output wire data_enable
);

// hdata
always @ (posedge rst or posedge clk)
begin
    if(rst) begin
        hdata <= 0;
    end
    else begin
        if (hdata == (HMAX - 1))
            hdata <= 0;
        else
            hdata <= hdata + 1;        
    end
end

// vdata
always @ (posedge rst or posedge clk)
begin
    if(rst) begin
        vdata <= 0;
    end
    else begin
        if (hdata == (HMAX - 1)) 
        begin
            if (vdata == (VMAX - 1))
                vdata <= 0;
            else
                vdata <= vdata + 1;
        end        
    end
end

// addr
always @ (posedge rst or posedge clk)
begin
    if(rst) begin
        addr <= 0;
    end
    else begin
        if (addr >= 480000) begin
            addr <= 0;
        end
        else if(data_enable) begin
            addr <= addr + 1;
        end
    end
end

// hsync & vsync & blank
assign hsync = ((hdata >= HFP) && (hdata < HSP)) ? HSPP : !HSPP;
assign vsync = ((vdata >= VFP) && (vdata < VSP)) ? VSPP : !VSPP;
assign data_enable = ((hdata < HSIZE) & (vdata < VSIZE));

endmodule