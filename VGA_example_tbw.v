`timescale 1ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:19:29 02/25/2016
// Design Name:   VGA_example
// Module Name:   C:/Users/Mark Johnson/Documents/GitHub/VGA_example/VGA_example_tbw.v
// Project Name:  VGA_example
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VGA_example
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "./includes/colours.v"

module VGA_example_tbw;

	// Inputs
	reg clk;
	reg resetn;

	// Outputs
	wire [26:1] MemAdr;
	wire MemOE;
	wire MemWR;
	wire RamAdv;
	wire RamCS;
	wire RamClk;
	wire RamCRE;
	wire RamLB;
	wire RamUB;
	wire RamWait;
	wire FlashRp;
	wire FlashCS;
	wire [7:0] pixel;
	wire Hsync;
	wire Vsync;

	// Bidirs
	wire [15:0] MemDB;

	// Instantiate the Unit Under Test (UUT)
	VGA_example uut (
		.clk(clk), 
		.resetn(resetn), 
		.MemAdr(MemAdr), 
		.MemDB(MemDB), 
		.MemOE(MemOE), 
		.MemWR(MemWR), 
		.RamAdv(RamAdv), 
		.RamCS(RamCS), 
		.RamClk(RamClk), 
		.RamCRE(RamCRE), 
		.RamLB(RamLB), 
		.RamUB(RamUB), 
		.RamWait(RamWait), 
		.FlashRp(FlashRp), 
		.FlashCS(FlashCS),
		.vgaRed(pixel[7:5]),
		.vgaGreen(pixel[4:2]),
		.vgaBlue(pixel[1:0]),
		.Hsync(Hsync),
		.Vsync(Vsync)   
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		resetn = 0;

		// Wait 100 ns for global reset to finish
		#100;
      resetn = 1;
		// Add stimulus here
		forever
			clk = #10 ~clk;
	end
      
endmodule

