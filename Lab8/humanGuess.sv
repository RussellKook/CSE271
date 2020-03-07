module humanGuess (clk, reset, humanNum, SW, compare);
	output logic [7:0] humanNum;
	input logic clk, reset, compare;
	input logic [9:2] SW;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			humanNum <= '0;
		end else if(compare) begin
			humanNum <= {SW[9], SW[8], SW[7], SW[6], SW[5], SW[4], SW[3], SW[2]};
		end else begin
			humanNum <= humanNum;
		end
	end
	
endmodule

module humanGuess_testbench();
	 logic [7:0] humanNum;
	logic clk, reset, compare;
	logic [9:2] SW;

	humanGuess dut (.clk, .reset, .humanNum, .SW, .compare);
	
	// Set up the clock.   
	parameter CLOCK_PERIOD = 100;   
	initial begin 
		clk <= '0;  
		forever #( CLOCK_PERIOD / 2 ) clk <= ~clk;   
	end      

	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin                        
						@(posedge clk);    
		reset <= 1; @(posedge clk);    
		reset <= 0; @(posedge clk);                        
						@(posedge clk);                        
						@(posedge clk);                        
			@(posedge clk);                
						@(posedge clk);                
						@(posedge clk);                
						@(posedge clk);                        
						@(posedge clk);                        
	 SW[9] <= 1; SW[8] <= 1; SW[7] <=1;  SW[6] <= 1; SW[5] <= 0; SW[4] <= 0; SW[3] <= 0; SW[2] <= 0;				@(posedge clk);                        
						@(posedge clk);               
						@(posedge clk);                        
		compare <= 1;				@(posedge clk);   
		compare<=0;				@(posedge clk); 
						@(posedge clk); 	
		 SW[9] <= 1; SW[8] <= 0; SW[7] <=0;  SW[6] <= 0; SW[5] <= 0; SW[4] <= 0; SW[3] <= 0; SW[2] <= 0;				@(posedge clk); 
						@(posedge clk); 	
						@(posedge clk); 
		compare <=1;				@(posedge clk);
		compare <=0;				@(posedge clk); 
						@(posedge clk);					
		$stop; // End the simulation.   
	end  
endmodule 