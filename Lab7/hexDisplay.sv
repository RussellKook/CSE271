//this modules takes in a winner variable corresponsding
//to if player0 or player1 won the tug of war and outputs
//a "1" or a "0" on the HEX0 to show who won
module hexDisplay (clk, reset, hex, led, keyIn);
	
	//output corresponds to output hex, 7bit
	output logic [6:0] hex;
	
	//input corresponds to winner and enable
	input logic led, keyIn, clk, reset;
	
	//		0, 1, 2, 3, 4, 5, 6, 7
	enum {A, B, C, D, E, F, G, H} ps, ns;
	//logic to display hex outputs
	always_comb begin
		case(ps)
			//display 0
			//				 
			A:begin   //6543210
				hex = 7'b1000000;
				if(led == 1 & keyIn == 1) begin
					ns = B;
				end
				else
					ns = A;
			end
			//display 1
			B:
			begin
				hex = 7'b1111001;
				if(led == 1 & keyIn == 1) 
					ns = C;
				else
					ns = B;
			end
			//display 2
			C:
			begin
				hex = 7'b0100100;//7'b0100100
				if(led == 1 & keyIn == 1) 
					ns = D;
				else
					ns = C;
			end
			//display 3
			D:
			begin
				hex = 7'b0110000;//7'b0110000
				if(led == 1 & keyIn == 1) 
					ns = E;
				else
					ns = D;
			end
			//display 4
			E:
			begin
				hex = 7'b0011001;//7'b0011001
				if(led == 1 & keyIn == 1) 
					ns = F;
				else
					ns = E;
			end
			//display 5
			F:
			begin
				hex = 7'b0010010;//7'b0010010
				if(led == 1 & keyIn == 1) 
					ns = G;
				else
					ns = F;
			end
			//display 6
			G:
			begin
				hex = 7'b0000010;//7'b0000010
				if(led == 1 & keyIn == 1) 
					ns = H;
				else
					ns = G;
			end
			H:
			//display 7
			begin
				hex = 7'b1111000;//7'b1111000
				if(led == 1 & keyIn == 1) 
					ns = H;
				else
					ns = H;
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
	 logic clk, reset, led, keyIn;
	 logic [6:0] hex;
	 
	 hexDisplay dut (.clk, .reset, .hex, .led, .keyIn);
	 
	 // Set up the clock.
	 parameter CLOCK_PERIOD = 100;
	 
	 initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	 end

	 // Set up the inputs to the design. Each line is a clock cycle.
	 initial begin
		led <= 0; keyIn <= 0;							      @(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 1; keyIn <= 1;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 1; keyIn <= 1;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 1; keyIn <= 1;				@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
														@(posedge clk);
														@(posedge clk);
		led <= 1; keyIn <= 1;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 1; keyIn <= 1;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);	
		led <= 1; keyIn <= 1;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 1; keyIn <= 1;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 1; keyIn <= 1;				@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
														@(posedge clk);
														@(posedge clk);
		led <= 1; keyIn <= 1;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 0; keyIn <= 0;																@(posedge clk);
																		@(posedge clk);
																		@(posedge clk);
		led <= 1; keyIn <= 1;																@(posedge clk);							
		$stop; // End the simulation.
	end
endmodule 
	