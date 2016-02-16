`timescale 1ns / 10ps
`include "vga_defs.v"
`include "pack_array.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:20:49 02/16/2016
// Design Name:   main
// Module Name:   C:/Users/Mark Johnson/Documents/Github/comp3601_blue_15s2/DoubleBuffer/main_tbw.v
// Project Name:  DoubleBuffer
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module main_tbw;

	// Inputs
	reg clk;
	reg resetn;

	// Outputs
	wire [2457599:0] packed_buffer;

	// Internal Variables
	wire [`PIXEL_SIZE-1:0] buffer [`HEIGHT-1:0][`WIDTH-1:0];
	
	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.resetn(resetn), 
		.packed_buffer(packed_buffer)
	);

	`UNPACK_2D_ARRAY(`WIDTH, `HEIGHT, `PIXEL_SIZE, packed_buffer, buffer);
	
//	genvar i, j;
//	
//	generate 
//		for (i = 0; i < `HEIGHT; i = i + 1) begin : vertical_raster
//			for (j = 0; j < `WIDTH; j = j + 1) begin : horizontal_raster
//				assign buffer[i][j] = packed_buffer[(i*`WIDTH + j)*`PIXEL_SIZE];
//			end
//		end
//	endgenerate

	initial begin
		// Initialize Inputs
		clk = 0;
		resetn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		resetn = 1;
		forever
			clk = #100 ~clk;
	end
      
endmodule

