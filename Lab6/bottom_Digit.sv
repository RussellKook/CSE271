//logic for last digit of student id #
module bottom_Digit(out, sw3, sw2, sw1, sw0);
	output logic out;
	input logic sw3, sw2, sw1, sw0;
	
	assign out = ~((sw0 ~| ~sw1) ~& (sw2 ~| sw3));
	
endmodule

module next_Digit_up(out, sw7, sw6, sw5, sw4);
	output logic out;
	input logic sw7, sw6, sw5, sw4;
	
	assign out = (~sw7 ~& sw6) ~| (sw5 ~& sw4);
	
end module

module
	
	