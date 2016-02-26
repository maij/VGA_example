`timescale 1ns / 100ps
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
`include "../includes/colours.v"

`define FACE_X (`WIDTH/2)
`define FACE_Y (`HEIGHT/2)

`define FACE_RAD_SQ (((3*`HEIGHT)/8)**2)
`define FACE_RAD_LO_LIM (`FACE_RAD_SQ - `FACE_RAD_SQ/128)
`define FACE_RAD_HI_LIM (`FACE_RAD_SQ + `FACE_RAD_SQ/128)

`define LEFT_EYE_X   (240)
`define LEFT_EYE_Y   (280)
`define RIGHT_EYE_X  (380)
`define RIGHT_EYE_Y  (280)

`define EYE_RAD_SQ     ((`HEIGHT/16)**2)
`define EYE_RAD_LO_LIM (`EYE_RAD_SQ - `EYE_RAD_SQ/128)
`define EYE_RAD_HI_LIM (`EYE_RAD_SQ + `EYE_RAD_SQ/128)

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
	 
reg [`PIXEL_SIZE-1:0] pixel;

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
	$display("Face Centre      = (%d,%d)", `FACE_X, `FACE_Y);
	$display("Face Range       = [%d,%d]", `FACE_RAD_LO_LIM, `FACE_RAD_HI_LIM);
	$display("Left Eye Centre  = (%d,%d)", `LEFT_EYE_X, `LEFT_EYE_Y);
	$display("Right Eye Centre = (%d,%d)", `RIGHT_EYE_X, `RIGHT_EYE_Y);
	$display("Right Eye Range  = [%d,%d]", `EYE_RAD_LO_LIM, `EYE_RAD_HI_LIM);
end

//assign pixel = blank ? `PIXEL_SIZE'b0 : MemDB;

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
//			$display("Face Calc: a^2 + b^2 = %d,  c^2 = %d", (hcount - `WIDTH/2)**2 + (vcount - `HEIGHT/2)**2, (`WIDTH/2)**2);
			if (
					( (hcount - `FACE_X)**2 + (vcount - `FACE_Y)**2 <= `FACE_RAD_HI_LIM) &&
					( (hcount - `FACE_X)**2 + (vcount - `FACE_Y)**2 >= `FACE_RAD_LO_LIM) 
				)
    	   begin
				pixel <= `YELLOW; // Yellow circle outline
				$display("FACE: x = %3d y=%3d", hcount, vcount);

			// Left eye or right eye
			end else if ( 
							  ( (hcount - `LEFT_EYE_X )**2 + (vcount - `LEFT_EYE_Y )**2 <= `EYE_RAD_SQ) || 
							  ( (hcount - `RIGHT_EYE_X)**2 + (vcount - `RIGHT_EYE_Y)**2 <= `EYE_RAD_SQ) 
							) 
			begin
				pixel <= `RED;
				$display("EYE : x = %3d y=%3d", hcount, vcount);
			end else 
				pixel <= `BLACK; // Black default
				
//			blank_count = 0;
//			$display("hcount = %d", hcount);
//			$display("vcount = %d", vcount);
		end else begin
			pixel <= `BLACK;
//			blank_count = blank_count + 1;
//			$display("Blanking time = %d", blank_count);
		end
	end

endmodule
