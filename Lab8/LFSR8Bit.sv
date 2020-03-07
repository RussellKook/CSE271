module LFSR8Bit (clock, reset, code, enable, LEDR, test);

	localparam NumOfBit = 8;
	output logic [8:1] test;
	output logic [1:0] LEDR;
	
	input  logic clock, reset, enable;
	output logic [ NumOfBit : 1 ] code;
	
	logic [ NumOfBit : 1 ] Q;
	logic D;
	
	enum {A,B} ns, ps;
	
	always_comb begin
		case(ps) 
		A:begin
			LEDR[0] = 1;
			LEDR[1] = 0;
			if(enable)
				ns = B;
			else 
				ns = A;
		end
		B:begin
			LEDR[0] = 1;
			LEDR[1] = 1;
			ns = B;
			end
		endcase
	end
	
	always_ff @(posedge clock) begin
		if(reset)
			ps <= A;
		else
			ps <= ns;
	end
	
	always_ff @(posedge clock) begin
		if(enable)
			code <= Q;
	end

	xnor( D, Q[ 8 ], Q[ 6 ], Q[5], Q[4], &Q[ NumOfBit - 1 : 1 ] );

	always_ff @( posedge clock ) begin
		if ( reset ) begin
			Q <= '0;
		end else begin
			Q <= { Q[ NumOfBit - 1 : 1 ], D };	//[4,3,2,1] = [D,3,2,1] or [10,9,8,7,6,5,4,3,2,1] = [D,9,8,7,6,5,4,3,2,1]
		end
	end
	assign test = Q;
endmodule 


module LFSR8Bit_testbench();   
	logic  clk, reset, enable;

	logic [8:1] code, test;
	logic [1:0] LEDR;
	
	LFSR8Bit dut( .clock( clk ), .reset, .code, .enable, .LEDR, .test);      

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
		enable <=1;	@(posedge clk);                
		enable <=0;				@(posedge clk);                
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