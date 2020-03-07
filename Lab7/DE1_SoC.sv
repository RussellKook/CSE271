module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	
   // Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 15;
	clock_divider cdiv (CLOCK_50, clk);

	 
	 
	// Hook up FSM inputs and outputs.
	logic reset, led1, led2, led3, led4, led5, led6, led7, led8, led9;
	logic [6:0] hex0, hex1;
	//inputs to tug of way
	assign reset = SW[9]; // Reset when SW[9] is pressed.
	
	tugOfWar call (.clk(clk[whichClock]), .reset, .player0(KEY[0]), .player1(KEY[3]), .sw(SW[8:0]), .hex0, .hex1, .led1, .led2, .led3, .led4, .led5, .led6, .led7, .led8, .led9); 
	
	assign HEX0 = hex0;
	assign HEX1 = hex1;
	assign LEDR[1] = led1;
	assign LEDR[2] = led2;
	assign LEDR[3] = led3;
	assign LEDR[4] = led4;
	assign LEDR[5] = led5;
	assign LEDR[6] = led6;
	assign LEDR[7] = led7;
	assign LEDR[8] = led8;
	assign LEDR[9] = led9;
 
 
 
 
 
 

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
