//awef
module keyToDff (out, clk, reset, keyIn);
	output logic out;
	input logic keyIn, clk, reset;

	
	// State variables.
	enum { A, B } ps, ns;

	// Next State logic
	always_comb begin
		case (ps)
			A: if(keyIn == 0)begin
				out = 0;
				ns = B;
			end else begin 
				out = 0;
				ns = A;
			end
			B: if(keyIn == 1)begin
				out = 1;
				ns = A;
			end else begin
				out = 0;
				ns = B;
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

module keyToDff_testbench();
	 logic clk, reset, keyIn;
	 logic out;
	 keyToDff dut (.out, .clk, .reset, .keyIn);
	 // Set up the clock.
	 parameter CLOCK_PERIOD = 100;
	 
	 initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	 end

	 // Set up the inputs to the design. Each line is a clock cycle.
	 initial begin
		keyIn <= 1;			      @(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 1; 								@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 1;								@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 1;					@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 0;								@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 0;			      @(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 0; 								@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 0;								@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 1;					@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		keyIn <= 1;								@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);								
		$stop; // End the simulation.
	end
endmodule 
	
