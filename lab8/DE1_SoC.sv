// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_0, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
	 input  logic [35:0] GPIO_0;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
    assign HEX0 = '1;
    assign HEX1 = '1;
    assign HEX2 = '1;
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST, game_on;                   // reset - toggle this on startup
	 
	 assign RST = SW[9];				// Reset is tied to switch nine.
	 //assign LEDR[9] = RST;			// Show an LED when RST is active
	 
	 assign game_on = SW[0];			// This switch is for determining whether or not the simulation will run
	 
	 logic Select;							// Select button for placing pattern
	 assign Select = GPIO_0[14]; 
	 
	 logic [4:0] ui0, ui1, ui2;
	 
	 // Filter the user input
	always_ff @(posedge SYSTEM_CLOCK) begin
		ui0 <= {Select, KEY};
		ui1 <= ui0;
	end
	 
	 /* UserInput module for processing of the KEYS into a single module, each key press is read as a single input. */
	 UserInput #(.WIDTH(5)) ui (.clk(SYSTEM_CLOCK), .reset(RST), .buttons(ui1), .out(ui2));
	 	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);

	 //SetPattern pat (.clk(SYSTEM_CLOCK), .reset(RST), .red(), .move(keys), .initialPattern(), .RedPixels, .GrnPixels);
	 MovingDot md (.clk(SYSTEM_CLOCK), .clk_slow(clk[23]), .reset(RST), .game_on, .move(ui2[3:0]), .select(ui2[4]), .RedPixels, .GrnPixels);
	 
endmodule