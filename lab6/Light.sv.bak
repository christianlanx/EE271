module Light(clk, reset, is_center, in, out);
	input logic 		clk, reset, is_center;
	input logic [3:0] in;
	output logic 		out;
	
	typedef enum logic {ON, OFF} state;
	state ps, ns;
	
	always_comb begin
		case (ps)
			ON: 	if ((in == 4'b0100) | (in == 4'b1000))	ns = OFF;
					else												ns = ON;
			OFF: 	if ((in == 4'b0110) | (in == 4'b1001)) ns = ON;
					else												ns = OFF;
		endcase
	end
	
	assign out = (ps == ON);
	
	always_ff @(posedge clk) begin
		if (reset)
			if (is_center) ps <= ON;
			else 				ps <= OFF;
		else
			ps <= ns;
	end
	
endmodule

module CenterLight_testbench();

	logic 		clk, reset, is_center;
	logic [3:0] in;
	logic 		out;
	
	assign is_center = 1;
	
	Light dut(clk, reset, is_center, in, out);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin										@(posedge clk);
			reset <= 1;									@(posedge clk);
			reset <= 0; in <= 4'b0000;				@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0100;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0001;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0101;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b1000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0001;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b1001;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b1000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0010;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b1010;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0100;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0010;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0110;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		$stop;
	end
endmodule

module NormalLight_testbench();

	logic 		clk, reset, is_center;
	logic [3:0] in;
	logic 		out;
	
	assign is_center = 0;
	
	Light dut(clk, reset, is_center, in, out);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin										@(posedge clk);
			reset <= 1;									@(posedge clk);
			reset <= 0; in <= 4'b0000;				@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0100;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0010;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0110;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0100;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0001;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0101;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b1000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0001;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b1001;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b1000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0010;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b1010;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
			in <= 4'b0000;								@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		$stop;
	end
endmodule