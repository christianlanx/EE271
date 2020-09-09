module Comparator_10b(A, B, out);
	input  logic [9:0] A, B;
	output logic out;
	
	logic [9:0] car, outty;
	
	F_Adder FA(.A(~A[0]), .B(B[0]), .c_in(1), .out(outty[0]), .c_out(car[0]));
	genvar i;
	generate
		for (i = 1; i<10; i++) begin: eachFA
			F_Adder FA(.A(~A[i]), .b(B[i]), .c_in(car[i-1]), .out(outty[i]), .c_out(car[i]));
		end
	endgenerate
	
	assign out = ((car[9]&~car[8])|(car[9]&outty[9])|(~car[8]&outty[9]));
endmodule	

module F_Adder(A, B, c_in, out, c_out);
	input  logic A, B, c_in;
	output logic out, c_out;
	
	assign out   = (A^B)^c_in;
	assign c_out = (c_in&(A^B))|(A&B);
endmodule

module F_Adder_10b(A, B, c_in, out, c_out);
	input  logic [9:0] A, B;
	output logic [9:0] out;
	input  logic c_in;
	output logic c_out;
	
	logic [9:0] car;
	
	F_Adder FA (.A(A[0]), .B(B[0]), .c_in(c_in), .out(out[0]), .c_out(car[0]));
	genvar i;
	generate
		for(i=1; i<10; i++) begin : eachFA
			F_Adder FA (.A(A[i]), .B(B[i]), .c_in(car[i-1]), .out(out[i]), .c_out(car[i]));
		end
	endgenerate
	
	assign c_out = car[9];
endmodule

module F_Adder_testbench();
	logic A, B, c_in, out, c_out;
	
	F_Adder dut(A, B, c_in, out, c_out);
	
	initial begin
		A <= 0; B <= 0; c_in <= 0; #10;
		A <= 0; B <= 0; c_in <= 1; #10;
		A <= 0; B <= 1; c_in <= 0; #10;
		A <= 0; B <= 1; c_in <= 1; #10;
		A <= 1; B <= 0; c_in <= 0; #10;
		A <= 1; B <= 0; c_in <= 1; #10;
		A <= 1; B <= 1; c_in <= 0; #10;
		A <= 1; B <= 1; c_in <= 1; #10;
	end
endmodule

module fulladder_10b_testbench();
	logic [9:0] A, B;
	logic c_in, out, c_out;
	
	fulladder dut(A, B, c_in, out, c_out);
	
	integer i, j;
	
	initial begin
		for (i = 0; i<1024; i++) begin
			A = i;
			for (j = 0; j < 1024; j++) begin
				B = j;
				c_in = 0; #10;
				c_in = 1; #10;
			end
		end
	end
endmodule

module Comparator_10b_testbench();
	logic [9:0] A, B;
	logic out;
	
	Comparator_10b dut(A, B, out);
	
	integer i, j;
	
	initial begin
		for ( i = 0; i < 16; i++) begin
			A = i;
			for (j = 0; j < 16; j++) begin
				B = j; #10;
			end
		end
	end
endmodule
		