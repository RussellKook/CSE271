module displayHex (hex, sw1, sw0, reset); 

	output logic [6:0] hex;
	input logic sw1, sw0;
	input logic reset;
	
	always_comb begin
		if(reset) begin
			hex = 7'b1000000;//0
		end else if (sw1 == 0 && sw0 == 0) begin
			hex = 7'b1000000;//0
		end else if (sw1 == 0 && sw0 == 1) begin
			hex = 7'b1111001;//1
		end else if (sw1 == 1 && sw0 == 0) begin
			hex = 7'b0100100;//2
		end else if (sw1 == 1 && sw0 == 1) begin
			hex = 7'b0110000;//3
		end else begin
			hex = 7'bx;
		end
	end
	
endmodule

module displayHex_testbench();
	
	logic [6:0] hex;
	logic sw1, sw0;
	logic reset;
	
	displayHex dut (.hex, .sw1, .sw0, .reset);
	
	initial begin
		reset = 1; #10;
						#10;
		reset = 0; #10;
						#10;
		sw1 = 1; sw0 = 1; # 10;
							#10;
		sw1 = 0; sw0 = 0; # 10;
							#10;
		sw1 = 0; sw0 = 1; # 10;
							#10;					
		
	end
endmodule 
