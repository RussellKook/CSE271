module create_4digit_code (clk, reset, code);
	input logic clk, reset;
	output logic [7:0] code;
	logic [7:0] random8bit;
	
	
	//this is constantly making random 8bit numbers
	LFSR8Bit generateNumber (.clock(clk), .reset, .code, .enable);

	
	//will choose a "code" only once, on reset 
	always_ff @(posedge clk) begin
		if(reset)
			code <= random8bit;
		else
			code <= code;
	end	
	
endmodule
			
module create_4digit_code_testbench();   

	logic clk, reset;
	logic [7:0] code;


	create_4digit_code dut (.clk, .reset, .code);     

	// Set up the clock.   
	parameter CLOCK_PERIOD = 100;   
	initial begin 
		clk <= '0;  
		forever #( CLOCK_PERIOD / 2 ) clk <= ~clk;   
	end      

	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin                        
						@(posedge clk);    
						@(posedge clk);
						@(posedge clk);
		reset <= 1; @(posedge clk);  
						@(posedge clk);
						@(posedge clk);
		reset <= 0; @(posedge clk);                        
						@(posedge clk);                        
						@(posedge clk);                        
						@(posedge clk);                
						@(posedge clk);                
						@(posedge clk);                
						@(posedge clk);                        
						@(posedge clk);                        
						@(posedge clk);                        
						@(posedge clk);               
		reset <= 1; @(posedge clk);
						@(posedge clk);
						@(posedge clk);
		reset <= 0; @(posedge clk);                        
						@(posedge clk);   
						@(posedge clk); 
						@(posedge clk); 	
						@(posedge clk); 
						@(posedge clk); 	
						@(posedge clk); 
						@(posedge clk);
						@(posedge clk); 
						@(posedge clk);
						@(posedge clk);                
						@(posedge clk);                        
						@(posedge clk);                        
						@(posedge clk);                        
						@(posedge clk);               
						@(posedge clk);               
		reset <= 1; @(posedge clk);
						@(posedge clk);
						@(posedge clk);
		reset <= 0; @(posedge clk);                        
						@(posedge clk);   
						@(posedge clk); 
						@(posedge clk); 	
						@(posedge clk); 
						@(posedge clk); 	
						@(posedge clk); 
						@(posedge clk);                        
						@(posedge clk);   
						@(posedge clk); 
						@(posedge clk); 	
						@(posedge clk); 
						@(posedge clk); 	
						@(posedge clk); 
						@(posedge clk);
						@(posedge clk); 
						@(posedge clk);					
		$stop; // End the simulation.   
	end  
endmodule 
	