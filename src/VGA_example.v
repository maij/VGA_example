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

`define SQUARED(INPUT) (INPUT*INPUT)

`define FACE_X (`WIDTH/2)
`define FACE_Y (`HEIGHT/2)

`define FACE_RAD_SQ (`SQUARED((3*`HEIGHT)/8))
`define FACE_RAD_LO_LIM (`FACE_RAD_SQ - `FACE_RAD_SQ/128)
`define FACE_RAD_HI_LIM (`FACE_RAD_SQ + `FACE_RAD_SQ/128)

`define LEFT_EYE_X   (240)
`define LEFT_EYE_Y   (280)
`define RIGHT_EYE_X  (380)
`define RIGHT_EYE_Y  (280)

`define EYE_RAD_SQ     (`SQUARED(`HEIGHT/16))
`define EYE_RAD_LO_LIM (`EYE_RAD_SQ - `EYE_RAD_SQ/128)
`define EYE_RAD_HI_LIM (`EYE_RAD_SQ + `EYE_RAD_SQ/128)

`define GRID_SIZE 32

module VGA_example(
		input clk,
		input resetn,
        
        input clk_switch,
        input clk_btn,
		
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

// To prevent errors when generating bit file, assign all outputs
initial
   pixel <= `PIXEL_SIZE'b0;

// VGA Inputs
wire clk_40MHz;
wire clk_25MHz;

// VGA Outputs
wire blank;
wire [10:0] hcount;
wire [10:0] vcount;

// Generate clocks for 25MHz and 40MHz
// Reset is active high for clkgen

// Game of Life stuff
wire [1023:0] grid;
assign con_clk = clk_switch ? slow_clk : clk_btn;
clkgen i_clkgen(.CLK_IN1(clk), .CLK_40MHZ(clk_40MHz), .CLK_25MHZ(clk_25MHz), .RESET(~resetn));
conway i_conway(.clk(con_clk), .resetn(resetn), .grid_pack(grid));
shiftclock i_shiftclock(.clk_in(clk_25MHz), .clk_out(slow_clk));

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

`ifdef HIGH_RES
	always @(posedge clk_40MHz) begin
`else
	always @(posedge clk_25MHz) begin
`endif
		if (~blank) begin
            pixel <= (grid[((vcount/15*`GRID_SIZE) + (hcount - 1)/20)]) ? `WHITE : `BLACK ;
//            pixel <= `WHITE;
//        end
// Four quadrants
//			if      (hcount < `WIDTH/2 && vcount < `HEIGHT/2)
//				pixel <= `RED;
//			else if (hcount < `WIDTH/2 && vcount >= `HEIGHT/2)
//				pixel <= `GREEN;
//			else if (hcount >= `WIDTH/2 && vcount < `HEIGHT/2)
//				pixel <= `BLUE;
//			else
//				pixel <= `WHITE;

// Eesti Flag
//			if      (vcount < (`HEIGHT*43)/128)
//				pixel <= `BLUE | 8'b00010100;
//			else if      (vcount < (`HEIGHT*86)/128)
//				pixel <= `BLACK;
//			else
//				pixel <= `WHITE;

		end else 
			pixel <= `BLACK;
	end

endmodule
