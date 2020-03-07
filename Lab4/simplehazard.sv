module simplehazard (LEDR, clk, reset, SW);
	output logic [9:0] LEDR;
	input logic clk, reset;
	input logic [9:0] SW;
	
	// State variables.
	enum { A, B, C, D } ps, ns;

	// Next State logic
	always_comb begin
		case (ps)
			A://010
			if (~SW[1] & ~SW[0]) begin
				LEDR[2] = 1; LEDR[1] = 0; LEDR[0] = 1;
				ns = D;
			end else if(~SW[1] & SW[0]) begin
				LEDR[2] = 0; LEDR[1] = 0; LEDR[0] = 1;
				ns = B;
			end else begin 
				LEDR[2] = 1; LEDR[1] = 0; LEDR[0] = 0;
				ns = C;
			end
			B://001
			if (~SW[1] & ~SW[0]) begin
				LEDR[2] = 1; LEDR[1] = 0; LEDR[0] = 1;
				ns = D;
			end else if(~SW[1] & SW[0]) begin
				LEDR[2] = 0; LEDR[1] = 1; LEDR[0] = 0;
				ns = A;
			end else begin 
				LEDR[2] = 1; LEDR[1] = 0; LEDR[0] = 0;
				ns = C;
			end
			C: //100
			if (~SW[1] & ~SW[0]) begin
				LEDR[2] = 1; LEDR[1] = 0; LEDR[0] = 1;
				ns = D;
			end else if(~SW[1] & SW[0]) begin
				LEDR[2] = 0; LEDR[1] = 0; LEDR[0] = 1;
				ns = B;
			end else begin 
				LEDR[2] = 0; LEDR[1] = 1; LEDR[0] = 0;
				ns = A;
			end
			D: //101
			if (~SW[1] & ~SW[0]) begin
				LEDR[2] = 0; LEDR[1] = 1; LEDR[0] = 0;
				ns = A;
			end else if(~SW[1] & SW[0]) begin
				LEDR[2] = 0; LEDR[1] = 0; LEDR[0] = 1;
				ns = B;
			end else begin 
				LEDR[2] = 1; LEDR[1] = 0; LEDR[0] = 0;
				ns = C;
			end
		endcase
	end
endmodule 

	// Output logic - could also be another always, or part of above block.
	//assign out = (ps == C);

	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end

endmodule 

module simplehazard_testbench();
	 logic clk, reset, SW[1], SW[0];
	 logic LEDR[2], LEDR[1], LEDR[0];

	 simplehazard dut (.clk, .reset, .SW[1], .SW[0], .LEDR[2], .LEDR[1], .LEDR[0]);

	 // Set up the clock.
	 parameter CLOCK_PERIOD=100;
	 initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	 end

	 // Set up the inputs to the design. Each line is a clock cycle.
	 initial begin
		SW[1] <= 0 SW[0] <= 0   @(posedge clk);
										@(posedge clk);
										@(posedge clk);
		 								@(posedge clk);
		SW[1] <= 0 SW[0] <= 1	@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		SW[1] <= 1 SW[0] <= 0	@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		SW[1] <= 1 SW[0] <= 1	@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);
										@(posedge clk);								
		 $stop; // End the simulation.
		 end
	endmodule