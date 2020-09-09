module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

	output logic [9:0] LEDR;
	input  logic [3:0] KEY; // True when not pressed, False when pressed
	input  logic [9:0] SW;

	// Hook up FSM inputs and outputs.
	logic  reset;
	assign reset = SW[9]; // Reset when SW[9] is switched.
	
	logic BL, BR;
	logic [9:1] out;
	logic [1:0] keys1, keys2;
	
	always_ff @(posedge CLOCK_50) begin
		keys1[0] <= KEY[0];
		keys1[1] <= KEY[3];
	end
	
	always_ff @(posedge CLOCK_50) begin
		keys2 <= keys1;
	end
	
	UserIn Left		(.clk(CLOCK_50), .reset, .key(keys2[1]), .out(BL));
	UserIn Right	(.clk(CLOCK_50), .reset, .key(keys2[0]), .out(BR));
	
	Light one	(.clk(CLOCK_50), .reset, .is_center(0), .l_in(BL), .r_in(BR), .l_on(out[2]), 	.r_on(0), 		.out(out[1]));
	Light two	(.clk(CLOCK_50), .reset, .is_center(0), .l_in(BL), .r_in(BR), .l_on(out[3]), 	.r_on(out[1]),	.out(out[2]));
	Light three	(.clk(CLOCK_50), .reset, .is_center(0), .l_in(BL), .r_in(BR), .l_on(out[4]), 	.r_on(out[2]),	.out(out[3]));
	Light four	(.clk(CLOCK_50), .reset, .is_center(0), .l_in(BL), .r_in(BR), .l_on(out[5]), 	.r_on(out[3]),	.out(out[4]));
	Light five	(.clk(CLOCK_50), .reset, .is_center(1), .l_in(BL), .r_in(BR), .l_on(out[6]), 	.r_on(out[4]),	.out(out[5]));
	Light six	(.clk(CLOCK_50), .reset, .is_center(0), .l_in(BL), .r_in(BR), .l_on(out[7]), 	.r_on(out[5]),	.out(out[6]));
	Light seven	(.clk(CLOCK_50), .reset, .is_center(0), .l_in(BL), .r_in(BR), .l_on(out[8]), 	.r_on(out[6]),	.out(out[7]));
	Light eight	(.clk(CLOCK_50), .reset, .is_center(0), .l_in(BL), .r_in(BR), .l_on(out[9]), 	.r_on(out[7]),	.out(out[8]));
	Light nine	(.clk(CLOCK_50), .reset, .is_center(0), .l_in(BL), .r_in(BR), .l_on(0), 		.r_on(out[8]),	.out(out[9]));


	assign LEDR[9:1] = out[9:1];
	
	Victory V (.clk(CLOCK_50), .reset, .l_in(BL), .r_in(BR), .l_on(out[9]), .r_on(out[1]), .out(HEX0));

	// Show signals on LEDRs so we can see what is happening.
	assign LEDR[0] = reset;

endmodule

module Tug_Testbench();
	logic CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [3:0] KEY;
	logic [9:0] LEDR;
	logic [9:0] SW;
	
	DE1_SoC dut(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin																	@(posedge CLOCK_50);
		SW[9] <= 1;																	@(posedge CLOCK_50);
		SW<= 0; KEY <= 0;															@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		SW[9] <= 1;																	@(posedge CLOCK_50);
		SW<= 0; KEY <= 0;															@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		SW[9] <= 1;																	@(posedge CLOCK_50);
		SW<= 0; KEY <= 0;															@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1; KEY[3] <= 1;												@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1; KEY[3] <= 0;												@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1; KEY[0] <= 1;												@(posedge CLOCK_50);
		KEY[3] <= 0; KEY[0] <= 0;												@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[0] <= 1;																@(posedge CLOCK_50);
		KEY[0] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		KEY[3] <= 1;																@(posedge CLOCK_50);
		KEY[3] <= 0;																@(posedge CLOCK_50);
																						@(posedge CLOCK_50);
		$stop;
	end
endmodule