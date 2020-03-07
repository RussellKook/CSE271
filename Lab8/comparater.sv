module comparater (clk, reset, HEX5, HEX4, humanNum, code, compare);//, LEDR);//, test, testRight);
	
	input logic [7:0] code, humanNum;
	//output logic [9:0] LEDR; 
	output logic [6:0] HEX5, HEX4;
	input logic clk, reset, compare;
	//output logic [2:0] test, testRight;
	
	logic compareDelay1, compareDelay2;
	logic [2:0] counterRight4, counterRight3, counterRight2, counterRight1;
	logic [2:0] counterMisplaced4, counterMisplaced3, counterMisplaced2, counterMisplaced1;
	
	logic [4:1][2:0] digit, digitm;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			HEX4 <= '0;
		end else if (counterMisplaced1 == 3'b000) begin
			HEX4 <= 7'b1000000;//0
		end else if (counterMisplaced1 == 3'b001) begin
			HEX4 <= 7'b1111001;//1
		end else if (counterMisplaced1 == 3'b010) begin
			HEX4 <= 7'b0100100;//2
		end else if (counterMisplaced1 == 3'b011) begin
			HEX4 <= 7'b0110000;//3
		end else if (counterMisplaced1 == 3'b100) begin
			HEX4 <= 7'b0011001;//4
		end
	end
	
	always_ff @(posedge clk) begin
		if(reset) begin
			HEX5 <= '0;
		end else if (counterRight1 == 3'b000) begin
			HEX5 <= 7'b1000000;//0
		end else if (counterRight1 == 3'b001) begin
			HEX5 <= 7'b1111001;//1
		end else if (counterRight1 == 3'b010) begin
			HEX5 <= 7'b0100100;//2
		end else if (counterRight1 == 3'b011) begin
			HEX5 <= 7'b0110000;//3
		end else if (counterRight1 == 3'b100) begin
			HEX5 <= 7'b0011001;//4
		end
	end
	
	always_ff @(posedge clk) begin
		compareDelay1 <= compare;
	end
	
	always_ff @(posedge clk) begin
		compareDelay2 <= compareDelay1;
	end
	
	//misplaced
	always_ff @(posedge clk) begin
		if(reset) begin
			digitm <= '0;
		end else if(compareDelay2) begin
			if((humanNum[7:6] != code[7:6]) && ((code[7:6] == humanNum[5:4]) || (code[7:6] == humanNum[3:2]) || (code[7:6] == humanNum[1:0])))
				digitm[4] <= 3'b001;
			else
				digitm[4] <= 3'b000;
			if((humanNum[5:4] != code[5:4]) && ((code[5:4] == humanNum[7:6]) || (code[5:4] == humanNum[3:2]) || (code[5:4] == humanNum[1:0])))
				digitm[3] <= 3'b001;
			else
				digitm[3] <= 3'b000;
			if((humanNum[3:2] != code[3:2]) && ((code[3:2] == humanNum[7:6]) || (code[3:2] == humanNum[5:4]) || (code[3:2] == humanNum[1:0])))
				digitm[2] <= 3'b001;
			else
				digitm[2] <= 3'b000;
			if((humanNum[1:0] != code[1:0]) && ((code[1:0] == humanNum[7:6]) || (code[1:0] == humanNum[5:4]) || (code[1:0] == humanNum[3:2])))
				digitm[1] <= 3'b001;
			else
				digitm[1] <= 3'b000;
		end
	end
	
	always_ff @(posedge clk) begin
		counterMisplaced4 <= digitm[4];
	end
	
	always_ff @(posedge clk) begin
		counterMisplaced3 <= counterMisplaced4 + digitm[3];
	end
	
	always_ff @(posedge clk) begin
		counterMisplaced2 <= counterMisplaced3 + digitm[2];
	end
	
	always_ff @(posedge clk) begin
		counterMisplaced1 <= counterMisplaced2 + digitm[1];
	end
	
	/*
	always_comb begin
		case(counterMisplaced1)
		3'b000: HEX4 = 7'b1000000;//0
		3'b001: HEX4 = 7'b1111001;//1
		3'b010: HEX4 = 7'b0100100;//2
		3'b011: HEX4 = 7'b0110000;//3
		3'b100: HEX4 = 7'b0011001;//4
		default: HEX4 =7'bX;
		endcase
	end	
	*/
	//assign testRight = counterMisplaced3;
	//assign test = digitm[4];
	
	//correct
	always_ff @(posedge clk) begin
		if(reset) begin
			digit <= '0;
		end else	if(compareDelay2) begin
			if(humanNum[7:6] == code[7:6])
				digit[4] <= 3'b001;
			else 
				digit[4] <= 3'b000;
			if(humanNum[5:4] == code[5:4])
				digit[3] <= 3'b001;
			else 
				digit[3] <= 3'b000;
			if(humanNum[3:2] == code[3:2])
				digit[2] <= 3'b001;
			else 
				digit[2] <= 3'b000;
			if(humanNum[1:0] == code[1:0])
				digit[1] <= 3'b001;
			else 
				digit[1] <= 3'b000;
		end
	end
	
	always_ff @(posedge clk) begin
		counterRight4 <= digit[4];
	end
	
	always_ff @(posedge clk) begin
		counterRight3 <= counterRight4 + digit[3];
	end
	
	always_ff @(posedge clk) begin
		counterRight2 <= counterRight3 + digit[2];
	end
	
	always_ff @(posedge clk) begin
		counterRight1 <= counterRight2 + digit[1];
	end
	/*
	always_comb begin
		case(counterRight1)
			//					6543210
		3'b000: HEX5 = 7'b1000000;//0
		3'b001: HEX5 = 7'b1111001;//1
		3'b010: HEX5 = 7'b0100100;//2
		3'b011: HEX5 = 7'b0110000;//3
		3'b100: HEX5 = 7'b0011001;//4
		default: HEX5 = 7'bX;
		endcase
	end
	*/
endmodule 



module comparater_testbench();

	//logic [9:0] LEDR; 
	logic [7:0] code, humanNum;
	logic [6:0] HEX5, HEX4;
	logic  clk, reset, compare;
	//logic  [2:0] test, testRight;
	
	comparater dut (.clk, .reset, .HEX5, .HEX4, .humanNum, .code, .compare);//, .LEDR);//, .test, .testRight);

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
						@(posedge clk);                        
		reset <= 1;		@(posedge clk);                        
		reset <= 0;	@(posedge clk);    
			
						@(posedge clk);                
						@(posedge clk);                
		code <= '1;	humanNum <= '1;			@(posedge clk);                        
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
	

		