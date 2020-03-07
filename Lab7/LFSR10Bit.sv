module LFSR10Bit ( clock, reset, Q );
input  logic clock;
input  logic reset;

localparam NumOfBit = 10;
output logic [ NumOfBit : 1 ] Q;
logic D;

xnor( D, Q[ 10 ], Q[ 7 ], &Q[ NumOfBit - 1 : 1 ] );

always_ff @( posedge clock ) begin
	if ( reset ) begin
		Q <= '0;
	end else begin
		Q <= { Q[ NumOfBit - 1 : 1 ], D };	//[4,3,2,1] = [D,3,2,1] or [10,9,8,7,6,5,4,3,2,1] = [D,9,8,7,6,5,4,3,2,1]
	end
end

endmodule 


module LFSR10Bit_testbench();   
logic  clk, reset;

localparam NumOfBit = 10;
logic [ NumOfBit : 1 ] Q;

LFSR10Bit dut( .clock( clk ), .reset, .Q );      

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