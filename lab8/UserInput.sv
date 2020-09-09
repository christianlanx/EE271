module UserInput #(parameter WIDTH=4) (clk, reset, buttons, out);
	input  logic clk, reset;
	input  logic [WIDTH-1:0] buttons;
	output logic [WIDTH-1:0] out;
	
	logic [WIDTH-1:0] ps, ns;
	
	always_comb begin
			ns = buttons;
	end
	
	assign out = (buttons & ~ps);
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= 0;
		else
			ps <= ns;
	end
	
endmodule

module UserInput_testbench();
	logic clk, reset;
	logic [3:0] buttons, out;
	
	UserInput dut (clk, reset, buttons, out);
	
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin								@(posedge clk);
		reset <= 1; buttons <= 2'b0;		@(posedge clk);
		reset <= 0;								@(posedge clk);
													@(posedge clk);
		buttons <= 4'b0001;						@(posedge clk);
		buttons <= 4'b0000;						@(posedge clk);
													@(posedge clk);
		buttons <= 4'b0010;						@(posedge clk);
		buttons <= 4'b0000;						@(posedge clk);
													@(posedge clk);
		buttons <= 4'b0011;						@(posedge clk);
		buttons <= 4'b0000;						@(posedge clk);
													@(posedge clk);
		buttons <= 4'b0010;						@(posedge clk);
													@(posedge clk);
													@(posedge clk);
		buttons <= 4'b1000;						@(posedge clk);
													@(posedge clk);
		buttons <= 4'b0100;						@(posedge clk);
													@(posedge clk);
		buttons <= 4'b1100;						@(posedge clk);
													@(posedge clk);
		buttons <= 4'b1000;						@(posedge clk);
													@(posedge clk);
		buttons <= 4'b1100;						@(posedge clk);
													@(posedge clk);
		buttons <= 4'b0100;						@(posedge clk);
		buttons <= 4'b0000;						@(posedge clk);
		$stop;
	end
endmodule
