`ifndef VGA_DEFS_V
	`define VGA_DEFS_V

//	`define HIGH_RES
	`ifdef HIGH_RES
		`define RESOLUTION 1'b1 // For 800x600 @ 60Hz
		`define WIDTH 800
		`define HEIGHT 600
	`else
		`define RESOLUTION 1'b0 // For 640x480 @ 60Hz
		`define WIDTH  640
		`define HEIGHT 480	
	`endif
	
	`define PIXEL_SIZE 8
	`define PACKED_SIZE (`WIDTH)*(`PIXEL_SIZE)
	`define BUFFER_SIZE (`HEIGHT)*(`WIDTH)
	

`endif
