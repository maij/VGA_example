`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:52:00 02/22/2016 
// Design Name: 
// Module Name:    VGA_example 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "../includes/vga_defs.v"


module VGA_example(
		input clk,
		input resetn,
		
		// Cellular RAM signals
		output reg [26:1] MemAdr,
		inout  [15:0] MemDB,
		output MemOE,
		output MemWR,
		output RamAdv,
		output RamCS,  
		output RamClk, 
		output RamCRE, 
		output RamLB, 
		output RamUB,  
		output RamWait,
		
		output FlashRp,
		output FlashCS,
		// VGA Signals
		output [2:0] vgaRed,
		output [2:0] vgaGreen,
		output [2:1] vgaBlue,
		output Hsync,
		output Vsync      
    );
	 
wire [`PIXEL_SIZE-1:0] pixel;

assign vgaRed[2:0]   = pixel[7:5];
assign vgaGreen[2:0] = pixel[4:2];
assign vgaBlue[2:1]  = pixel[1:0];

// VGA Inputs
wire clk_40MHz;
wire clk_25MHz;

// VGA Outputs
wire blank;
wire [10:0] hcount;
wire [10:0] vcount;

// Generate clocks for 25MHz and 40MHz
// Reset is active high for clkgen
clkgen i_clkgen(clk, clk_40MHz, clk_25MHz, ~resetn);

/*
 * NOTE: It appears that hcount goes from 1 to 640, but vcount goes from 0 to 479
 * 	   which I think is a bit weird...
 */
VgaRefComp vga_timing(.CLK_25MHZ(clk_25MHz), 
							 .CLK_40MHZ(clk_40MHz), 
							 .RESOLUTION(`RESOLUTION), 
							 .RST(~resetn), // This entity treats reset as active high
							 .BLANK(blank), 
							 .HCOUNT(hcount),
							 .HS(Hsync),
							 .VCOUNT(vcount),
							 .VS(Vsync)
						  );

initial begin
`ifdef HIGH_RES
	$display("Resolution : 800x600 @ 60Hz");
`else
	$display("Resolution : 640x480 @ 60Hz");
`endif
end

assign pixel = blank ? `PIXEL_SIZE'b0 : MemDB;

//double_buffer buffer(clk, resetn, pixel, vline_sel, hline_sel);
//reg [31:0] blank_count = 0;
//initial
//	blank_count = 0;
	
`ifdef HIGH_RES
	always @(posedge clk_40MHz) begin
`else
	always @(posedge clk_25MHz) begin
`endif
		if (~blank) begin
			MemAdr = (hcount - 1) + vcount*`WIDTH;
//			blank_count = 0;
//			$display("hcount = %d", hcount);
//			$display("vcount = %d", vcount);
		end else begin
//			blank_count = blank_count + 1;
//			$display("Blanking time = %d", blank_count);
		end
	end

endmodule
