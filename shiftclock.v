module shiftclock (
        input clk_in,
        output reg clk_out);
        
        reg [25:0] counter = 26'b0;
        parameter C0 = 26'd12500000;
        initial 
            clk_out <= 0;
            
        always @(posedge clk_in) begin
            counter <= counter + 1;
            if (counter == C0) begin
                clk_out <= ~clk_out;
                counter <= 0;
            end
        end
endmodule
