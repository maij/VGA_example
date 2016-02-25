/*
 * clk_div.v
 */
 
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

