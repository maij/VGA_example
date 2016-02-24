`timescale 1ns / 10ps
`include "../../includes/vga_defs.v"
`include "../../includes/pack_array.v"

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

module double_buffer_tbw;

	// Inputs
	reg clk;
	reg resetn;
	
	function integer log2;
		input integer value;
		begin		
			value = value-1;
			for (log2=0; value>0; log2=log2+1)
				value = value>>1;
		end
	endfunction
	
	// Outputs
	wire [`PACKED_SIZE-1:0] packed_buffer;
	wire [log2(`HEIGHT):0] hline_sel;
	
	// Internal Variables
	wire [`PIXEL_SIZE-1:0] buffer [`WIDTH-1:0];
	
	// Instantiate the Unit Under Test (UUT)
	double_buffer uut (
		.clk(clk), 
		.resetn(resetn), 
		.packed_buffer(packed_buffer),
		.hline_sel(hline_sel)
	);

	generate 
		genvar j;
		for (j = 0; j < `WIDTH; j = j + 1) begin : horizontal_raster
			assign buffer[j][`PIXEL_SIZE-1:0] = packed_buffer[(j+1)*`PIXEL_SIZE-1:j*`PIXEL_SIZE];
		end
	endgenerate

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

