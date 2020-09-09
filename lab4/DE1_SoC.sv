// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input  logic [3:0] KEY;
 input  logic [9:0] SW;
 
 UPC(.discounted(LEDR[1]), .stolen(LEDR[0]), .u(SW[9]), .p(SW[8]), .c(SW[7]), .m(SW[0]));
 assign HEX0 = '1;
 hex1 one(.bcd(SW[9:7]), .leds(HEX1));
 hex2 two(.bcd(SW[9:7]), .leds(HEX2));
 hex3 tre(.bcd(SW[9:7]), .leds(HEX3));
 hex4 qua(.bcd(SW[9:7]), .leds(HEX4));
 assign HEX5 = '1;
 //seg7 one(.bcd(SW[7:4]), .leds(HEX1));
 //seg7 zero(.bcd(SW[3:0]), .leds(HEX0));
endmodule




