module Comparator_10b(A, B, out);
	input  logic [9:0] A, B;
	output logic out;
	
	logic [10:0] car, outty;
	
	genvar i;
	generate
		for(i=0; i<11; i++) begin : eachFA
			if (i == 0)
				F_Adder FA(.A(~A[i]), .B(B[i]), .c_in(1'b1), 		.out(outty[i]), .c_out(car[i]));
			else if (i == 10)
				F_Adder FA(.A(1'b1),  .B(0),	  .c_in(car[i-1]), 	.out(outty[i]), .c_out(car[i]));
			else
				F_Adder FA(.A(~A[i]), .B(B[i]), .c_in(car[i-1]), 	.out(outty[i]), .c_out(car[i]));
		end
	endgenerate
	
	assign out = ((car[10]&(~car[9]))|(car[10]&outty[10])|((~car[9])&outty[10]));
endmodule	


module F_Adder(A, B, c_in, out, c_out);
	input  logic A, B, c_in;
	output logic out, c_out;
	
	assign out   = (A^B)^c_in;
	assign c_out = (c_in&(A^B))|(A&B);
endmodule

module F_Adder_10b(A_in, B_in, c_in, out, c_out);
	input  logic [9:0] A_in, B_in;
	output logic [9:0] out;
	input  logic c_in;
	output logic c_out;
	
	logic [8:0] car;
	
	genvar i;
	generate
		for(i=0; i<10; i++) begin : eachFA
			if (i == 0)
				F_Adder FA(.A(A_in[i]), .B(B_in[i]), .c_in, 				.out(out[i]), .c_out(car[i]));
			else if (i == 9)
				F_Adder FA(.A(A_in[i]), .B(B_in[i]), .c_in(car[i-1]), .out(out[i]), .c_out);
			else
				F_Adder FA(.A(A_in[i]), .B(B_in[i]), .c_in(car[i-1]), .out(out[i]), .c_out(car[i]));
		end
	endgenerate
	
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

module F_Adder_10b_testbench();
	logic [9:0] A, B, out;
	logic c_in, c_out;
	
	F_Adder_10b dut(A, B, c_in, out, c_out);
	
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
		for ( i = 0; i < 1024; i++) begin
			A = i;
			for (j = 0; j < 1024; j++) begin
				B = j; #10;
			end
		end
	end
endmodule
		