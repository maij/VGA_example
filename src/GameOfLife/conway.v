`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:30:08 06/05/2016 
// Design Name: 
// Module Name:    conway 
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
module conway(
    input clk,
    input resetn,
    output reg [1023:0] grid_pack
    );
    
    reg grid[31:0][31:0];
    reg newGrid[31:0][31:0];
    reg [3:0] neighbours[31:0][31:0];
    
    initial 
        grid_pack <= 1024'b0;
        
    generate
        genvar i,j,y,z;
        for (i = 0; i < 32; i = i + 1) begin : iloop
            for (j = 0; j < 32; j = j + 1) begin  : jloop
                // Initialise grid to be 0
                initial begin
                        grid[i][j] <= 0;
                end
                
                // Determine the next state of each grid element from neighbours
                always @(*) begin
                    case (neighbours[i][j])
                        0 : newGrid[i][j] <= 0; // starvation if alive, no generation if dead
                        1 : newGrid[i][j] <= 0; // starvation if alive, no generation if dead
                        2 : newGrid[i][j] <= grid[i][j] ? 1'b1 : 1'b0; // continued living, no generation if dead
                        3 : newGrid[i][j] <= 1; // continued living, spontaneous life if dead
                        4 : newGrid[i][j] <= 0; // overcrowding if alive, no generation if dead
                        5 : newGrid[i][j] <= 0; // overcrowding if alive, no generation if dead
                        6 : newGrid[i][j] <= 0; // overcrowding if alive, no generation if dead
                        7 : newGrid[i][j] <= 0; // overcrowding if alive, no generation if dead
                        8 : newGrid[i][j] <= 0; // overcrowding if alive, no generation if dead
                        default : newGrid[i][j] <= 0; /* shouldn't occur */
                    endcase
                end
                
                // Count the number of neighbours
                always @(*) begin
                    if (i == 0 || j == 0 || i == 31 || j == 31) begin // edge, corner case
                        if (i == 0) begin
                            if (j == 0) begin
                                // Bottom left corner
                                neighbours[i][j] <= grid[i+1][j] + grid[i][j+1] + grid[i+1][j+1];
                            end else if (j == 31) begin
                                // Bottom right corner
                                neighbours[i][j] <= grid[i+1][j] + grid[i][j-1] + grid[i+1][j-1];
                            end else begin
                                // Bottom edge
                                neighbours[i][j] <= grid[i+1][j] + grid[i][j-1] + grid[i+1][j-1] +
                                                   grid[i+1][j+1] + grid[i][j+1];
                            end
                        end else if (i == 31) begin
                            if (j == 0) begin
                                // Top left corner
                                neighbours[i][j] <= grid[i-1][j] + grid[i][j+1] + grid[i-1][j+1];
                            end else if (j == 31) begin
                                // Top right corner
                                neighbours[i][j] <= grid[i-1][j] + grid[i][j-1] + grid[i-1][j-1];
                            end else begin
                                // Top edge
                                neighbours[i][j] <= grid[i-1][j] + grid[i][j-1] + grid[i-1][j-1] +
                                                   grid[i-1][j+1] + grid[i][j+1];
                            end
                        end else if (j == 0) begin
                            // Left edge
                            neighbours[i][j] <= grid[i+1][j] + grid[i-1][j] + grid[i-1][j+1] +
                                               grid[i][j+1] + grid[i+1][j+1];
                        end else if (j == 31) begin
                            // Right edge
                            neighbours[i][j] <= grid[i-1][j] + grid[i+1][j] + grid[i+1][j-1] +
                                               grid[i][j-1] + grid[i-1][j-1];
                        end
//                        neighbours[i][j] = 3;
                    end else begin
                        neighbours[i][j] <= grid[i-1][j-1] + grid[i-1][j] + grid[i-1][j+1] +
                                           grid[i][j-1] /*+ grid[i][j]*/ + grid[i][j+1]   + 
                                           grid[i+1][j-1] + grid[i+1][j] + grid[i+1][j+1];
                    end
                end
                
                
                // Update the game, on reset load an initial state
                always @(posedge clk, negedge resetn) begin
                    if (~resetn)
//                        if ((i == 16 && j == 15) || (i == 16 && j == 16) || (i == 16 && j == 17)) // blinker
//                            grid[i][j] <= 1;

                        // glider
//                        if ((i == 17 && j == 16) ||
//                            (i == 16 && j == 17) || 
//                            (i == 15 && (j == 15 || j == 16 || j == 17)))
//                            grid[i][j] <= 1;
//                            
                        // Pulsar
                        if (((i == 16+6 || i == 16+1 || i == 16-1 || i == 16-6) 
                            && (j == 12 || j == 13 || j == 14 || j == 18 || j == 19 || j == 20)) ||
                            ((i == 16+4 || i == 16+3 || i == 16+2 || i == 16-2 || i == 16-3 || i == 16-4) 
                            && (j == 10 || j == 15 || j == 17 || j == 22)))
                            grid[i][j] <= 1;
                        else
                            grid[i][j] <= 0;
                    else
                        grid[i][j] <= newGrid[i][j];
                end
                
                // Pack the current state
                always @(*) begin
                    grid_pack[i*32+j] <= grid[i][j];
                end
            end
        end
    endgenerate
    
endmodule
