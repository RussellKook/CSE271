//logic for last digit of student id #
module bottom_Digit(out, sw);
	output logic out;
	input logic sw3, sw2, sw1, sw0;
	input logic [3:0] sw;
	
	assign out = (~sw[0]) & sw[1] & (~sw[2]) & (~sw[3]);
	
endmodule

//logic for second to last digit of student id#
module next_Digit_Up(out, sw7, sw6, sw5, sw4);
	output logic out;
	input logic sw7, sw6, sw5, sw4;
   input logic [3:0] sw;
	
	assign out = (~sw[3]) & sw[2] & sw[1] & sw[0];
		
endmodule

//logic for both last and second to last digits
module last_2_Digits( out , SW )
module last_2_Digits(out, sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7);
	output logic out;
	input logic sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7;
	input logic [9:0] SW;
	logic w1, w2;
	
	//.other module variable(assign to this inside one)
	bottom_Digit bDsubmodule (.out(w1), .sw3(sw3), .sw2(sw2), .sw1(sw1), .sw0(sw0));
	next_Digit_Up nDUsubmodule (.out(w2), .sw(SW[7:4]));
	
	assign out = w1 & w2; 
	
endmodule 

//tester
module last_2_Digits_testbench();
	logic sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7;
	logic out;
	
	last_2_Digits dut (.out, .sw0, .sw1, .sw2, .sw3, .sw4, .sw5, .sw6, .sw7);
	
	//try all the combinations
	integer i;
	initial begin
		for(i = 0; i < 256; i++) begin
			//essentially makes a truth table with sw7 on left and sw0 on right
			{sw7, sw6, sw5, sw4, sw3, sw2, sw1, sw0} = i; #10;
		end
	end
endmodule
	

	
	