module comparater (out, a, b);
	input logic [9:0] a, b;
	output logic out;
	
	always_comb begin
		if(a[9] != b[9]) begin
			if(a[9] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[8] != b[8]) begin
			if(a[8] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[7] != b[7]) begin
			if(a[7] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[6] != b[6]) begin
			if(a[6] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[5] != b[5]) begin
			if(a[5] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[4] != b[4]) begin
			if(a[4] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[3] != b[3]) begin
			if(a[3] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[2] != b[2]) begin
			if(a[2] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[1] != b[1]) begin
			if(a[1] == 1)
				out = 1;
			else 
				out = 0;
		end else if (a[0] != b[0]) begin
			if(a[0] == 1)
				out = 1;
			else 
				out = 0;
		end else 
			out = 0;
	end
endmodule 

module comparater_testbench();
	logic [9:0] a, b;
	logic out;
	
	comparater dut (.out, .a, .b);
	
	initial begin 
		a = 10'b1000000000; b = 10'b1000000000; #10;
		a = 10'b1100000000; b = 10'b1000000000; #10;
		a = 10'b1010000000; b = 10'b1100000000; #10;
		a = 10'b0000000001; b = 10'b0000000000; #10;
	end
endmodule 
		