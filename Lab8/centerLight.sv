module centerLight (clk, reset, resetCenter, L, R, NL, NR, lightOn);
	input logic clk, reset, resetCenter;
	
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, NL, NR;
	
	// when lightOn is true, the center light should be on.
	output logic lightOn;
	
	// State variables.
	//A is on and B is off
	enum { A, B } ps, ns;
	
	//comb logic
	always_comb begin
		case(ps)
			//LED 5 starts on
			A: 
			if(L == 1 & R == 0) begin
				ns = B;
			end else if(L == 0 & R == 1) begin
				ns = B;
			end else begin
				ns = A;
			end
			
			B://LED 5 is OFF
			if(L == 1 & R == 0 & NR == 1) begin
				ns = A;
			end else if(L == 0 & R == 1 & NL == 1) begin
				ns = A;
			end else begin
				ns = B;
			end
		endcase
	end
	
	assign lightOn = (ps == A);
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset | resetCenter)
			ps <= A;
		else
			ps <= ns;
	end
	
endmodule 

module centerLight_testbench();
	 logic clk, reset, resetCenter, L, R, NL, NR;
	 logic lightOn;
	 
	 centerLight dut (.clk, .reset, .resetCenter, .L, .R, .NL, .NR, .lightOn);
	 
	 // Set up the clock.
	 parameter CLOCK_PERIOD = 100;
	 
	 initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	 end

	 // Set up the inputs to the design. Each line is a clock cycle.
	 initial begin
		L <= 0; R <= 0; NL <= 0; NR <= 0;			      @(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		L <= 1; R <= 0; NL <= 0; NR <= 1;					@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		L <= 0; R <= 1; NL <= 1; NR <= 0;					@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		L <= 0; R <= 1;											@(posedge clk);
																		@(posedge clk);
		R <= 1;														@(posedge clk);
																		@(posedge clk);
		R <= 1;														@(posedge clk);
																		@(posedge clk);
		R <= 1;														@(posedge clk);
																		@(posedge clk);
		R <= 1;														@(posedge clk);
		resetCenter <= 1;											@(posedge clk);
																		@(posedge clk);	
		L <= 0; R <= 0; NL <= 0; NR <= 0;			      @(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		L <= 1; R <= 0; NL <= 0; NR <= 1;					@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		L <= 0; R <= 1; NL <= 1; NR <= 0;					@(posedge clk);							
		$stop; // End the simulation.
	end
endmodule 