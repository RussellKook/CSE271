//this modules take in a upc code in the form of a switch
// and outputs 4 HEX LEDs to display what is being sold
module fred (HEX5, HEX4, HEX3, HEX2, SW);
	
	//output corresponds to hex5-hex2
	output logic [6:0] HEX5, HEX4, HEX3, HEX2;
	
	//input corresponds to Sw9-0 only using 9,8,7 tho
	input logic [9:0] SW;
	
	logic [2:0] upc;
	assign upc = {SW[9], SW[8], SW[7]};
	
	//logic to display hex outputs
	always_comb begin
		case(upc)
		//    upc     LEDS of HEX
		//    210       6543210
			//belt 
			3'b000: 
				begin
					HEX5 = 7'b0000000;
					HEX4 = 7'b0000110;	
					HEX3 = 7'b1000111;
					HEX2 = 7'b1111111;
				end
				
			//cap
			3'b001: 
				begin
					HEX5 = 7'b1000110;
					HEX4 = 7'b0001000;	
					HEX3 = 7'b0001100;
					HEX2 = 7'b1111111;
				end
				
			//gold
			3'b011: 
				begin
					HEX5 = 7'b0000010;
					HEX4 = 7'b1000000;	
					HEX3 = 7'b1000111;
					HEX2 = 7'b0100001;
				end
				
			//glasses
			3'b100: 
				begin
					HEX5 = 7'b0000010;
					HEX4 = 7'b1000111;	
					HEX3 = 7'b0001000;
					HEX2 = 7'b0010010;
				end
				
			//phone
			3'b101: 
				begin
					HEX5 = 7'b0001100;
					HEX4 = 7'b0001011;	
					HEX3 = 7'b1000000;
					HEX2 = 7'b0101011;
				end
				
			//earring
			3'b110: 
				begin
					HEX5 = 7'b0000110;
					HEX4 = 7'b0001000;	
					HEX3 = 7'b0101111;
					HEX2 = 7'b0101111;
				end
				
			//default
			default: 
				begin
					HEX5 = 7'bX;
					HEX4 = 7'bX;	
					HEX3 = 7'bX;
					HEX2 = 7'bX;
				end
		endcase
	end
endmodule
	
module fred_testbench();
	logic [9:0] SW;
	logic [6:0] HEX5, HEX4, HEX3, HEX2;
	
	fred dut(.HEX5(HEX5), .HEX4(HEX4), .HEX3(HEX3), .HEX2(HEX2), .SW(SW));
	
	integer i;
	initial begin
		for(i = 0; i <8; i++) begin
			{SW[9], SW[8], SW[7]} = i; #10;
		end
	end
endmodule
	