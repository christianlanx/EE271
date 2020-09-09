module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  logic CLOCK_50; // 50MHz clock.
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input  logic [3:0] KEY; // True when not pressed, False when pressed
	input  logic [9:0] SW;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	parameter whichClock = 15;
	clock_divider cdiv (.clock(CLOCK_50),.reset(reset),.divided_clocks(clk));

	// Hook up FSM inputs and outputs.
	logic  reset, game_reset, Compr_out, victory_l, victory_r;
	logic [1:0] U_In_out, buttons1, buttons2;
	logic [2:0] Computer_count, Player_count;
	logic [9:0] LFSR_out;
	logic [9:1] leds;
	
	lfsr_10 LFSR (.clk(clk[whichClock]), .reset(reset), .out(LFSR_out));
	
	Comparator_10b Compr (.A({1'b0, SW[8:0]}), .B(LFSR_out), .out(Compr_out));
	
	UserInput U_In (.clk(clk[whichClock]), .reset(game_reset), .buttons(buttons2), .out(U_In_out));
	
	genvar i;
	generate
		for (i = 1; i < 10; i++) begin : EachLed
			if (i == 1)
				Light2 Led(.clk(clk[whichClock]), .reset(game_reset), .is_center(1'b0), .in({U_In_out, leds[i+1],1'b0}), 	 .out(leds[i]));
			else if (i == 5)
				Light2 Led(.clk(clk[whichClock]), .reset(game_reset), .is_center(1'b1), .in({U_In_out, leds[i+1],leds[i-1]}),.out(leds[i]));
			else if (i == 9)
				Light2 Led(.clk(clk[whichClock]), .reset(game_reset), .is_center(1'b0), .in({U_In_out, 1'b0,		leds[i-1]}), .out(leds[i]));
			else
				Light2 Led(.clk(clk[whichClock]), .reset(game_reset), .is_center(1'b0), .in({U_In_out, leds[i+1],leds[i-1]}),.out(leds[i]));
		end
	endgenerate
	
	Victory2 v	(.clk(clk[whichClock]), .reset, .in({U_In_out, leds[9], leds[1]}), .out({victory_l, victory_r}));
	
	Counter_3b Computer (.clk(clk[whichClock]), .reset, .in(victory_l), .out(Computer_count));
	Counter_3b Player	(.clk(clk[whichClock]), .reset, .in(victory_r), .out(Player_count));
	
	seg7 left  (.bcd({1'b0, Computer_count}), .leds(HEX5));
	seg7 right (.bcd({1'b0, Player_count}), 	.leds(HEX0));
	

	// Show signals on LEDRs so we can see what is happening.
	assign reset = SW[9];
	assign LEDR[9:1] = leds[9:1];
	assign LEDR[0] = reset;
	assign game_reset = (victory_l | victory_r | reset);
	
	// Filter the user input
	always_ff @(posedge clk[whichClock]) begin
		buttons1 <= {Compr_out, ~KEY[0]};
		buttons2 <= buttons1;
	end

endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, reset, divided_clocks);
	input logic reset, clock;
	output logic [31:0] divided_clocks = 0;

	always_ff @(posedge clock) begin
		divided_clocks <= divided_clocks + 1;
	end
endmodule 

module Cyber_War_testbench();
	logic CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [3:0] KEY;
	logic [9:0] LEDR, SW;
	
	DE1_SoC dut(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	parameter CLOCK_PERIOD = 50;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin																@(posedge CLOCK_50);
		SW[9] <= 1;																@(posedge CLOCK_50);
		SW<= 10'b0000010000;													@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
																					@(posedge CLOCK_50);
		$stop;
	end
endmodule
	
		
	