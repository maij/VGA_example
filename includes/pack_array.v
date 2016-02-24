`ifndef PACK_ARRAY_V
	`define PACK_ARRAY_V
	
	`define PACK_1D_ARRAY(PK_WIDTH, PK_HEIGHT, PK_SRC, PK_DEST) \
		genvar i; \
		generate \
			for (i = 0; i < PK_HEIGHT; i = i + 1) begin : vertical_raster \
					assign PK_DEST[(i+1)*PK_WIDTH - 1 : i*PK_WIDTH] = PK_SRC[i][PK_HEIGHT - 1 : 0]; \
			end \
		endgenerate 
		
	`define UNPACK_1D_ARRAY(PK_WIDTH, PK_HEIGHT, PK_SRC, PK_DEST) \
		genvar i; \
		generate \
			for (i = 0; i < PK_HEIGHT; i = i + 1) begin : vertical_raster \
				assign PK_SRC[i][PK_HEIGHT - 1 : 0] = PK_DEST[(i+1)*PK_WIDTH - 1 : i*PK_WIDTH]; \
			end \
		endgenerate 
	
	`define PACK_2D_ARRAY(PK_WIDTH, PK_HEIGHT, PK_VAL_SIZE, PK_SRC, PK_DEST) \
		genvar i, j; \
		generate \
			for (i = 0; i < PK_HEIGHT; i = i + 1) begin : vertical_raster \
				for (j = 0; j < PK_WIDTH; j = j + 1) begin : vertical_raster \
					assign PK_DEST[(i*PK_WIDTH + j + 1)*PK_VAL_SIZE - 1 : (i*PK_WIDTH + j)*PK_VAL_SIZE] = PK_SRC[i][j][PK_VAL_SIZE - 1:0]; \
				end \
			end \
		endgenerate 
		
	`define UNPACK_2D_ARRAY(PK_WIDTH, PK_HEIGHT, PK_VAL_SIZE, PK_SRC, PK_DEST) \
		genvar i, j; \
		generate \
			for (i = 0; i < PK_HEIGHT; i = i + 1) begin : vertical_raster \
					assign PK_SRC[i][j][PK_VAL_SIZE - 1:0] = PK_DEST[(i*PK_WIDTH + j + 1)*PK_VAL_SIZE - 1 : (i*PK_WIDTH + j)*PK_VAL_SIZE]; \
			end \
		endgenerate 
	
`endif
