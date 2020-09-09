module Counter #(parameter WIDTH=3) (clk, reset, in, out);
	input  logic clk, reset, in;
	output logic [WIDTH-1:0] out;
	
	logic [WIDTH-1:0] ps, ns;
	
	always_comb begin
		ns = ps + in;
	end
	
	assign out = ps;
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= 0;
		else
			ps <= ns;
	end
endmodule

module Counter_testbench();
	logic clk, reset, in;
	logic [2:0] out;
	
	Counter dut(.clk, .reset, .in, .out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin											@(posedge clk);
		reset <= 1;											@(posedge clk);
		reset <= 0; in <= 0;								@(posedge clk);
																@(posedge clk);
		in <= 1;												@(posedge clk);
		in <= 0;												@(posedge clk);
																@(posedge clk);
		in <= 1;												@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
		in <= 0;												@(posedge clk);
																@(posedge clk);
		in <= 1;												@(posedge clk);
		in <= 0;												@(posedge clk);
		reset <= 1;											@(posedge clk);
		reset <= 0;											@(posedge clk);
		$stop;
	end
endmodule