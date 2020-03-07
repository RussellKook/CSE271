module seg7 (bcd, leds);
 input logic [3:0] bcd;
 output logic [6:0] leds;

 always_comb begin
		case (bcd)
			// 3210     Light: 6543210
			4'b0000: leds = 7'b1000000; // 0
			4'b0001: leds = 7'b1111001; // 1
			4'b0010: leds = 7'b0100100; // 2
			4'b0011: leds = 7'b0110000; // 3
			4'b0100: leds = 7'b0011001; // 4
			4'b0101: leds = 7'b0010010; // 5
			4'b0110: leds = 7'b0000010; // 6
			4'b0111: leds = 7'b1111000; // 7
			4'b1000: leds = 7'b0000000; // 8
			4'b1001: leds = 7'b0010000; // 9
			default: leds = 7'bX;
		endcase
   end
endmodule 

module both (out0, out1, SW);
	//EX [3:0] bcd corresponds to bcd[3],bcd[2],bcd[1],bcd[0]
	
	//output represends which seg7 leds will light up
	output logic [6:0] out0, out1;
	//input is switches which will be converted to bcd
	input logic [9:0] SW;
	
	logic [3:0] bcd0, bcd1;
	
	//bcd input for 7seg switches
	assign bcd0 = {SW[3], SW[2], SW[1], SW[0]};
	assign bcd1 = {SW[7], SW[6], SW[5], SW[4]};
	
	seg7 light0 (.bcd(bcd0), .leds(out0));
	seg7 light1 (.bcd(bcd1), .leds(out1));
	
endmodule

//tester
module both_testbench();
	logic [9:0] SW;
	logic [6:0] out0, out1;
	
	both dut (.out0, .out1, .SW);
	
	//try all the combinations
	integer i;
	initial begin
		for(i = 0; i < 256; i++) begin
			//testing switches 7-4 and 3-0
			{SW[7], SW[6], SW[5], SW[4], SW[3], SW[2], SW[1], SW[0]} = i; #10;
		end
	end
endmodule


