module lfsr_10(clk, reset, out);
	input  logic clk, reset;
	output logic [9:0] out;
	
	logic [9:0] ps;
	
	always_ff @(posedge clk) begin
		if (reset)
			ps = 9'b0;
		else begin
			ps[0] <= ~(ps[9]^ps[6]);
			ps[1] <= ps[0];
			ps[2] <= ps[1];
			ps[3] <= ps[2];
			ps[4] <= ps[3];
			ps[5] <= ps[4];
			ps[6] <= ps[5];
			ps[7] <= ps[6];
			ps[8] <= ps[7];
			ps[9] <= ps[8];
			out 	<= ps;
		end
	end
endmodule

module lfsr_10_testbench();
	logic clk, reset;
	logic [9:0] out;
	
	 lfsr_10 dut(.clk, .reset, .out);
	 
	 parameter CLOCK_PERIOD = 100;
	 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	
	initial begin					@(posedge clk);
		reset <= 1;					@(posedge clk);
		reset <= 0;					@(posedge clk);
		for (i = 0; i < 2048; i++) begin
			@(posedge clk);
		end
		$stop;
	end
endmodule
