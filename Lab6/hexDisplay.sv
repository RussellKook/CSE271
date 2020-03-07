//this modules takes in a winner variable corresponsding
//to if player0 or player1 won the tug of war and outputs
//a "1" or a "0" on the HEX0 to show who won
module hexDisplay (clk, reset, hex0, led1, led9, L, R);
	
	//output corresponds to hex0, 7bit
	output logic [6:0] hex0;
	
	//input corresponds to winner and enable
	input logic led1, led9, L, R, clk, reset;
	
	enum {A, B, C} ps, ns;
	//logic to display hex outputs
	always_comb begin
		case(ps)
			A:begin
				hex0 = 7'b1111111;
				if(led9 == 1 & L == 1)
					ns = B;
				else if (led1 == 1 & R == 1)
					ns = C;
				else
					ns = A;
			end
			
			B:
			begin
				hex0 = 7'b1001111;// output a 1
				ns = B;
			end
			C:
			begin
				hex0 = 7'b1000000;// output a 0
				ns = C;
			end
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end

endmodule
	
module hexDisplay_testbench();
	 logic clk, reset, L, R, led1, led9;
	 logic [6:0] hex0;
	 
	 hexDisplay dut (.clk, .reset, .hex0, .led1, .led9, .L, .R);
	 
	 // Set up the clock.
	 parameter CLOCK_PERIOD = 100;
	 
	 initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	 end

	 // Set up the inputs to the design. Each line is a clock cycle.
	 initial begin
		L <= 0; R <= 0; led1 <= 0; led9 <= 0;		      @(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		L <= 1; R <= 0; led1 <= 0; led9 <= 1;				@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		L <= 0; R <= 1; led1 <= 1; led9 <= 0;				@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);								
		$stop; // End the simulation.
	end
endmodule 
	