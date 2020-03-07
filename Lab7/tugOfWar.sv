module tugOfWar(clk, reset, player0, player1, sw, hex0, hex1, led1, led2, led3, led4, led5, led6, led7, led8, led9);

	input logic player0, player1, reset, clk;
	input logic [8:0] sw;
	output logic led1, led2, led3, led4, led5, led6, led7, led8, led9;
	output logic [6:0] hex0, hex1;
	logic p0, p1, temp0, temp1, resetCenter;
	
	
	always_ff @(posedge clk) begin
		temp1 <= player1;
	end
	
	//p0 = cyber input
	cyber pc (.clk, .reset, .sw, .out(p0));
	
	//keyToDff person0 (.out(p0), .clk, .reset, .keyIn(temp0));
	keyToDff person1 (.out(p1), .clk, .reset, .keyIn(temp1));
	
	assign resetCenter = ((led1 & p0) | (led9 & p1));
	
	normalLight l1 (.clk, .reset, .L(p1), .R(p0), .NL(led2), .NR(1'b0), .lightOn(led1));
	normalLight	l2 (.clk, .reset, .L(p1), .R(p0), .NL(led3), .NR(led1), .lightOn(led2));
	normalLight	l3 (.clk, .reset, .L(p1), .R(p0), .NL(led4), .NR(led2), .lightOn(led3));
	normalLight	l4 (.clk, .reset, .L(p1), .R(p0), .NL(led5), .NR(led3), .lightOn(led4));
	centerLight	l5 (.clk, .reset, .resetCenter, .L(p1), .R(p0), .NL(led6), .NR(led4), .lightOn(led5));
	normalLight	l6 (.clk, .reset, .L(p1), .R(p0), .NL(led7), .NR(led5), .lightOn(led6));
	normalLight	l7 (.clk, .reset, .L(p1), .R(p0), .NL(led8), .NR(led6), .lightOn(led7));
	normalLight	l8 (.clk, .reset, .L(p1), .R(p0), .NL(led9), .NR(led7), .lightOn(led8));
	normalLight	l9 (.clk, .reset, .L(p1), .R(p0), .NL(1'b0), .NR(led8), .lightOn(led9));
	
	hexDisplay winner0 (.clk, .reset, .hex(hex0), .led(led1), .keyIn(p0));
	hexDisplay winner1 (.clk, .reset, .hex(hex1), .led(led9), .keyIn(p1));
	
endmodule 

module tugOfWar_testbench();
	 logic clk, reset, player0, player1, p0;
	 logic led1, led2, led3, led4, led5, led6, led7, led8, led9;
	 logic [6:0] hex0;
	 logic [8:0] sw;
	 
	 tugOfWar dut (.clk, .reset, .player0, .player1, .sw, .hex0, .led1, .led2, .led3, .led4, .led5, .led6, .led7, .led8, .led9);
	 
	 // Set up the clock.
	 parameter CLOCK_PERIOD = 100;
	 
	 initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	 end

	 // Set up the inputs to the design. Each line is a clock cycle.
	 initial begin
		reset <= 1;    						@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		reset <= 0;					 						@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 0; p0 <= 0;											@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
													@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 1; p0 <= 0;											@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 0; p0 <= 0;											@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 1; p0 <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 0; p0 <= 0;																@(posedge clk);
																		@(posedge clk);	
		player1 <= 1; p0 <= 0;											@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 0; p0 <= 0;											@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 1; p0 <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 0; p0 <= 0;																@(posedge clk);
																		@(posedge clk);
		player1 <= 1; p0 <= 0;											@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 0; p0 <= 0;											@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 1; p0 <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		player1 <= 0; p0 <= 0;																@(posedge clk);
																		@(posedge clk);																
		$stop; // End the simulation.
	end
endmodule 