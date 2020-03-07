module countCorrect (correct, clk, reset, humanNum, code, compare);
	
	input logic [7:0] code, humanNum;
	output logic [1:0] correct;
	input logic compare, clk, reset;
	logic [1:0]  temp1, temp2, temp3;
	
	enum {A,B,C,D} ns, ps;

	always_comb begin
		case(ps)
		A:begin
			if(compare) begin
				if(humanNum[7:6] == code[7:6]) begin
					temp2 = temp1 + 2'b01;
				end else begin
					temp2 = temp1;
				end
				ns = B;
			end else begin
				ns = A;
			end
		end
		B:begin
		end
		C:begin
		end
		D:begin
		end
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset)
			ps <= A;
		else
			ps <= ns;
	end

endmodule 

