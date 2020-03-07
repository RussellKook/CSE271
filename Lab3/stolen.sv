//logic for stolen
module stolen (out,SW);
	output logic out;
	input logic [9:0] SW;
	//9=U, 8=P, 7=C, 0=M
	logic w1;
	
	nor(w1, SW[0], SW[9], SW[7]);
	
	assign out = (!SW[0] & SW[9] & ~SW[8]) + w1;
	
endmodule 

//testbench for stolen
module stolen_testbench();
	logic [9:0] SW;
	logic out;
	
	stolen dut2 (.out, .SW);
	
	//try all the combinations
	integer i;
	initial begin
		for(i = 0; i < 16; i++) begin
			//essentially makes a truth table with sw7 on left and sw0 on right
			{SW[0], SW[7], SW[8], SW[9]} = i; #10;
		end
	end
endmodule

