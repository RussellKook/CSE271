//logic for discount
module discount (out,SW);
	output logic  out;
	input logic [9:0] SW;
	//9=U, 8=P, 7=C, 0=M
	
	assign out = SW[8] + (SW[9] & SW[7]);

endmodule	

//tester
module discount_testbench();
	logic [9:0] SW;
	logic out;
	
	discount dut1 (.out, .SW);
	
	//try all the combinations
	integer i;
	initial begin
		for(i = 0; i < 16; i++) begin
			//essentially makes a truth table with sw7 on left and sw0 on right
			{SW[0], SW[7], SW[8], SW[9]} = i; #10;
		end
	end
endmodule
