module compr_10(A, B, out);
	input  logic [9:0] A, B;
	output logic out;
	
endmodule

module halfadder(A, B, out, c_out);
	input  logic A, B;
	output logic out, c_out;
	
	xor(out, A, B);
	and(c_out, A, B);
endmodule

module fulladder(A, B, c_in, out, c_out);
	input  logic A, B, c_in;
	output logic out, c_out;
	logic ha_1_out, ha_1_c_out, ha_2_c_out;
	
	halfadder ha_1(.A(A), .B(B), .out(ha_1_out), .c_out(ha_1_c_out));
	halfadder ha_2(.A(ha_1_out), .B(c_in), .out(out), .c_out(ha_2_c_out));
	
	or(c_out, ha_1_c_out, ha_2_c_out);
endmodule

module fulladder_testbench();
	logic A, B, out, c_out;
	
	fulladder dut(A, B, out, c_out);
	
	initial begin
		A = 0; B = 0; #10;
		A = 0; B = 1; #10;
		A = 1; B = 0; #10;
		A = 1; B = 1; #10;
	end
endmodule