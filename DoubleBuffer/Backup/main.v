`include "vga_defs.v"
`include "pack_array.v"

module main(clk, resetn, packed_buffer);
	input clk;
	input resetn;
	output [`PACKED_SIZE-1:0] packed_buffer;
	
	wire [`PIXEL_SIZE-1:0] buffer [`HEIGHT-1:0][`WIDTH-1:0];
//	wire [`PIXEL_SIZE-1:0] curr_line [`WIDTH-1:0];

	reg [`PIXEL_SIZE-1:0] buffer_0 [`HEIGHT-1:0][`WIDTH-1:0];
	reg [`PIXEL_SIZE-1:0] buffer_1 [`HEIGHT-1:0][`WIDTH-1:0];
	reg buf_sel;
//	
//	function integer log2;
//		input integer value;
//		begin		
//			value = value-1;
//			for (log2=0; value>0; log2=log2+1)
//				value = value>>1;
//		end
//	endfunction
	
	// Counter for outputting hlines
//	reg [log2(`HEIGHT):0] hline_sel;
//	wire slow_clk;
	
	// Instances
//	clk_div cd1(clk, 1000, slow_clk);
	
//	always @(negedge resetn)
//		buf_sel <= 0;
	/*
	generate 
		genvar i, j;
		for (i = 0; i < `HEIGHT; i = i + 1) begin : vertical_raster
			//assign packed_buffer[(i+1)*`WIDTH*`PIXEL_SIZE - 1 : (i*`WIDTH)*`PIXEL_SIZE] = buffer[i];
			for (j = 0; j < `WIDTH; j = j + 1) begin : horizontal_raster
				// Toggle between the buffers with buf_sel
				//assign buffer[i][j] = buf_sel ? buffer_1[i][j] : buffer_0[i][j];
				//assign packed_buffer[(i*`WIDTH + j)*`PIXEL_SIZE] = buffer[i][j];
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
	*/
	
	//assign curr_line/*[`WIDTH-1:0][`PIXEL_SIZE-1:0]*/ = buffer[hline_sel]/*[`WIDTH-1:0][`PIXEL_SIZE-1:0]*/;
//	`PACK_1D_ARRAY(`PIXEL_SIZE,`WIDTH, curr_line, packed_buffer)
	`PACK_2D_ARRAY(`WIDTH, `HEIGHT, `PIXEL_SIZE, buffer, packed_buffer)
	endgenerate
	
	
//	always @(posedge slow_clk) begin
//		hline_sel <= (hline_sel + 1)%`HEIGHT;
//	end
endmodule

//
//module clk_div (input clk, input [31:0] div, output reg slow_clk);
//	reg [31:0] counter;
//	
//	initial begin
//		counter <= 0;
//		slow_clk <= 0;
//	end
//	
//	always @(posedge clk) begin
//		counter <= counter + 1;
//		if (counter == div) begin
//			counter <= 0;
//			slow_clk = ~slow_clk;
//		end
//	end
//endmodule
