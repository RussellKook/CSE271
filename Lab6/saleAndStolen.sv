module saleAndStolen (out0, out9, SW);
	output logic out0, out9;
	input logic [9:0] SW;
	
	discount call1 (.out(out9), .SW(SW));
	stolen call2 (.out(out0), .SW(SW));
	
endmodule

module saleAndStolen_testbench();
	logic [9:0] SW;
	logic out0, out9;
	
	saleAndStolen dut (.out0(out0), .out9(out9), .SW(SW));
	
	integer i;
	initial begin 
		for(i = 0; i < 16; i++) begin
			{SW[9], SW[8], SW[7], SW[0]} = i; #10;
		end
	end
endmodule
