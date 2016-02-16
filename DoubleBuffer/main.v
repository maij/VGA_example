`include "vga_defs.v"

module main(clk, resetn, packed_buffer);
	input clk;
	input resetn;
	output [`PACKED-1:0] packed_buffer;
	wire [`PIXEL_SIZE-1:0] buffer [`HEIGHT-1:0][`WIDTH-1:0];

	reg [`PIXEL_SIZE-1:0] buffer_0 [`HEIGHT-1:0][`WIDTH-1:0];
	reg [`PIXEL_SIZE-1:0] buffer_1 [`HEIGHT-1:0][`WIDTH-1:0];
	reg buf_sel;
	
	
	initial begin
		buf_sel = 0;
	end
	
	genvar i, j;
	generate 
		for (i = 0; i < `HEIGHT; i = i + 1) begin : vertical_raster
			for (j = 0; j < `WIDTH; j = j + 1) begin : horizontal_raster
				// Toggle between the buffers with buf_sel
				assign buffer[i][j] = buf_sel ? buffer_1[i][j] : buffer_0[i][j];
				assign packed_buffer[(i*`WIDTH + j)*`PIXEL_SIZE] = buffer[i][j];
				// Update alternate buffer to that which is selected
				always @(posedge clk, negedge resetn) begin
					if (~resetn) begin
						buffer_0[i][j] <= 0;
						buffer_1[i][j] <= 0;
					end else if (buf_sel) 
						buffer_0[i][j] <= ~buffer_1[i][j];
					else 
						buffer_1[i][j] <= ~buffer_0[i][j];
				end
			end
		end
	endgenerate
endmodule
