module cyber (clk, reset, sw, out);
	input logic clk, reset;
	input logic [8:0] sw;
	output logic out;
	logic [9:0] bit10, cyberNum;
	logic isBigger;
	
	assign bit10 = {1'b0, sw[8], sw[7], sw[6], sw[5], sw[4], sw[3], sw[2], sw[1], sw[0]};
	
	
	// make a number
	LFSR10Bit cyberNumber (.clock(clk), .reset, .Q(cyberNum));
	
	// if a > b
	comparater decide (.out(isBigger), .a(bit10), .b(cyberNum));
	
	always_ff @(posedge clk) begin
		if(isBigger)
			out <= 1;
		else 
			out <= 0;
	end 
endmodule
			
module cyber_testbench();   
logic  clk, reset;

logic [8:0] sw;
logic out;

cyber dut (.clk, .reset, .sw, .out);     

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
   sw[8] <= 0; sw[7] <= 0; sw[6] <= 0; sw[5] <= 0; sw[4] <=0; sw[3] <= 1; sw[2] <= 1; sw[1] <= 1; sw[0] <= 1;            @(posedge clk);                        
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
	