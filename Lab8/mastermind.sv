module mastermind(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, SW, KEY, clk, reset);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR; //if got it right make them all light up
	input logic [9:1] SW;
	input logic [3:0] KEY; // True when not pressed, False when pressed//3 is to compare the human number to code
	// 2 is to generate new computer code//0 is reset
	input logic clk, reset;
	logic key3temp1, key3temp2, key2temp1, key2temp2, key0temp1, key0temp2, compare, generateCode;
	logic [7:0] code, humanNum;
	//logic lightArray [7:0];
	
	always_ff @(posedge clk) begin
		if(reset) begin
			LEDR[9:2] <= 8'b00000000;
		end else if (compare) begin
			LEDR[9:2] <= LEDR[9:2] + 8'b00000001;
		end
	end
	
	//assign LEDR[9:2] = lightArray;
	
	always_ff @(posedge clk) begin
		key3temp1 <= KEY[3];
		key2temp1 <= KEY[2];
	end
	
	always_ff @(posedge clk) begin
		key3temp2 <= key3temp1;
		key2temp2 <= key2temp1;
	end
	
	
	//for hex display
	displayHex digit4 (.hex(HEX3), .sw1(SW[9]), .sw0(SW[8]), .reset);
	displayHex digit3 (.hex(HEX2), .sw1(SW[7]), .sw0(SW[6]), .reset);
	displayHex digit2 (.hex(HEX1), .sw1(SW[5]), .sw0(SW[4]), .reset);
	displayHex digit1 (.hex(HEX0), .sw1(SW[3]), .sw0(SW[2]), .reset);
	
	//KEY module for transition
	keyToDff compareGuess (.out(compare), .clk, .reset, .keyIn(key3temp2));
	keyToDff genCode (.out(generateCode), .clk, .reset, .keyIn(key2temp2));
	
	//output: 8bit "code"
	LFSR8Bit genComputerNum (.clock(clk), .reset, .code, .enable(generateCode), .LEDR(LEDR[1:0]));
	
	//output: 8bit human guess 
	humanGuess genHumanNum (.clk, .reset, .humanNum, .SW(SW[9:2]), .compare);
	
	comparater compareNumbers (.clk, .reset, .HEX5, .HEX4, .humanNum, .code, .compare); //, test, testRight);
	
	
endmodule 
