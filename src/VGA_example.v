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
		output MemAdr,
		inout MemDB,
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
		output FlashCS
	
    );
wire vline_sel, hline_sel;
wire [`PIXEL_SIZE-1:0] pixel;

//entity VgaRefComp is
//   port ( CLK_25MHz  : in    std_logic; 
//          CLK_40MHz  : in    std_logic; 
//          RESOLUTION : in    std_logic; 
//          RST        : in    std_logic; 
//          BLANK      : out   std_logic; 
//          HCOUNT     : out   std_logic_vector (10 downto 0); 
//          HS         : out   std_logic; 
//          VCOUNT     : out   std_logic_vector (10 downto 0); 
//          VS         : out   std_logic);
//end VgaRefComp;

wire blank;
wire [10:0] hcount;
wire hsync;
wire [10:0] vcount;
wire vsync;

// Only used for a higher resolution
assign clk_40MHz = 0;
//clk_div clk_40MHz_gen(clk, 2, clk_40MHz);
clk_div clk_25MHz_gen(clk, 4, clk_25MHz);

VgaRefComp vga_timing(.CLK_25MHZ(clk_25MHz), 
							 .CLK_40MHZ(clk_40MHz), 
							 .RESOLUTION(`RESOLUTION), 
							 .RST(~resetn), // This entity treats reset as active high
							 .BLANK(blank), 
							 .HCOUNT(hcount),
							 .HS(hsync),
							 .VCOUNT(vcount),
							 .VS(vsync)
						  );
//double_buffer buffer(clk, resetn, pixel, vline_sel, hline_sel);
	always @(posedge clk) begin
		
	end

endmodule

module clk_div (input clk, input [31:0] div, output reg slow_clk);
	reg [31:0] counter;
	
	initial begin
		counter <= 0;
		slow_clk <= 0;
	end
	
	always @(posedge clk) begin
		counter <= counter + 1;
		if (counter == {0, div[31:1]}) begin
			counter <= 0;
			slow_clk = ~slow_clk;
		end
	end
endmodule

