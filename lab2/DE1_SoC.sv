// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input  logic [3:0] KEY;
 input  logic [9:0] SW;

 // Default values, turns off the HEX displays
 seg7 zero(.bcd(SW[3:0]), .leds(HEX0));
 seg7 one (.bcd(SW[7:4]), .leds(HEX1));
 assign HEX2 = 7'b1111111;
 assign HEX3 = 7'b1111111;
 assign HEX4 = 7'b1111111;
 assign HEX5 = 7'b1111111;

 // Logic to check if SW[3]..SW[0] match your bottom digit,
 // and SW[7]..SW[4] match the next.
 // Result should drive LEDR[0].
 assign LEDR[0] = (SW[0] & SW[1] & SW[2] & ~SW[3] & ~SW[4] & SW[5] & ~SW[6] & ~SW[7]);
 // 27 = 00100111 //
endmodule

module seg7 (bcd, leds);
	input logic [3:0] bcd;
	output logic [6:0] leds;
	always_comb begin
		case (bcd)
			// 3210 				 6543210
			4'b0000: leds = 7'b1000000;
			4'b0001: leds = 7'b1111001;
			4'b0010: leds = 7'b0100100;
			4'b0011: leds = 7'b0110000;
			4'b0100: leds = 7'b0011001;
			4'b0101: leds = 7'b0010010;
			4'b0110: leds = 7'b0000010;
			4'b0111: leds = 7'b1111000;
			4'b1000: leds = 7'b0000000;
			4'b1001: leds = 7'b0010000;
			default: leds = 7'b1111111;
		endcase
	end
endmodule

module DE1_SoC_testbench();
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [9:0] LEDR;
 logic [3:0] KEY;
 logic [9:0] SW;

 DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);

 // Try all combinations of inputs.
 integer i;
 initial begin
 SW[9] = 1'b0;
 SW[8] = 1'b0;
 for(i = 0; i <256; i++) begin
 SW[7:0] = i; #10;
 end
 end
endmodule 