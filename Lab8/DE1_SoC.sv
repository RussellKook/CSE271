module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
   // Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 10;
	clock_divider cdiv (CLOCK_50, clk);


	
	mastermind call (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .LEDR, .SW(SW[9:1]), .KEY, .clk(clk[whichClock]), .reset(SW[0]));
	
 

 // Show signals on LEDRs so we can see what is happening.
 //assign LEDR = { clk[whichClock], 1'b0, reset, 2'b0, out};

endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
//[25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
 input logic clock;
 output logic [31:0] divided_clocks;

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end

endmodule 
