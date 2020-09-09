module MovingDot(clk, clk_slow, reset, game_on, move, select, RedPixels, GrnPixels);
	input  logic 					clk, clk_slow, reset, game_on, select;
	input  logic [3:0] 			move;
	output logic [15:0][15:0]	GrnPixels, RedPixels;
	
	logic [15:0][15:0] pattern, life;
	
	logic [3:0] row, col;
	
	moving_dot position (.clk, .reset, .move, .col, .row);

	genvar i, j;
	
	integer up, down, left, right;
	
	generate 
		for (i = 0; i < 16; i++) begin : eachRow
			for (j = 0; j < 16; j++) begin : eachCol
				toggly_bit tb (.clk, .reset, .active(GrnPixels[i][j]), .select, .out(pattern[i][j]));
				
				if (i == 0) begin
					if (j == 0)	 		celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[15][15]  ,life[15][j] , life[15][j+1] , life[i][15] , life[i][j+1], life[i+1][15] , life[i+1][j], life[i+1][j+1]}), .out(life[i][j]));
					else if (j == 15)	celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[15][j-1] ,life[15][j],  life[15][0]   , life[i][j-1], life[i][0]  , life[i+1][j-1], life[i+1][j], life[i+1][0]  }), .out(life[i][j]));
					else					celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[15][j-1] ,life[15][j] , life[15][j+1] , life[i][j-1], life[i][j+1], life[i+1][j-1], life[i+1][j], life[i+1][j+1]}), .out(life[i][j]));
				end else if (i == 15) begin
					if (j == 0)			celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[i-1][15] ,life[i-1][j], life[i-1][j+1], life[i][15] , life[i][j+1], life[0][15]   , life[0][j]  , life[0][j+1]  }), .out(life[i][j]));
					else if (j == 15)	celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[i-1][j-1],life[i-1][j], life[i-1][0]  , life[i][j-1], life[i][0]  , life[0][j-1]  , life[0][j]  , life[0][0]    }), .out(life[i][j]));
					else					celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[i-1][j-1],life[i-1][j], life[i-1][j+1], life[i][j-1], life[i][j+1], life[0][j-1]  , life[0][j]  , life[0][j+1]  }), .out(life[i][j]));
				end else begin
					if (j == 0)			celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[i-1][15] ,life[i-1][j], life[i-1][j+1], life[i][15] , life[i][j+1], life[i+1][15] , life[i+1][j], life[i+1][j+1]}), .out(life[i][j]));
					else if (j == 15)	celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[i-1][j-1],life[i-1][j], life[i-1][0]  , life[i][j-1], life[i][0]  , life[i+1][j-1], life[i+1][j], life[i+1][0]  }), .out(life[i][j]));
					else					celly c (.clk_slow, .reset, .game_on, .initial_state(pattern[i][j]), .neighbors({life[i-1][j-1],life[i-1][j], life[i-1][j+1], life[i][j-1], life[i][j+1], life[i+1][j-1], life[i+1][j], life[i+1][j+1]}), .out(life[i][j]));
				end
			end
		end
	endgenerate
	
	always_ff @(posedge clk) begin
		GrnPixels <= '0;
		if (reset) begin
			RedPixels <= '0;
			GrnPixels <= '0;
		end else if (game_on) begin
			RedPixels <= life;
		end else begin
			RedPixels <= life;
			GrnPixels[row][col] <= 1;
		end	
	end
	
endmodule

module moving_dot(clk, reset, move, row, col);
	input  logic clk, reset;
	input  logic [3:0] move;
	output logic [3:0] row, col;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			col = 4'b0;
			row = 4'b0;
		end else begin
			col <= col + move[1] - move[0];
			row <= row + move[2] - move[3];
		end
	end
endmodule
		
module toggly_bit (clk, reset, active, select, out);
	input  logic clk, reset, active, select;
	output logic out;
	
	always_ff @(posedge clk) begin
		if (reset)
			out <= 1'b0;
		else if (active & select)
			out <= ~out;
	end
endmodule


module celly #(parameter NEIGHBOR_SIZE=8) (clk_slow, reset, game_on, initial_state, neighbors, out);
	input  logic clk_slow, reset, game_on, initial_state;
	input  logic [NEIGHBOR_SIZE-1:0] neighbors;
	output logic out;
	
	logic alive, next_gen;
	int sum;
	
	summer s (.in(neighbors), .out(sum));
	
	life_logic ll (.alive, .neighbor_count(sum), .next_gen);
	
	always_ff @(posedge clk_slow) begin
		if (reset) 				alive <= 0;
		else if(game_on) 		alive <= next_gen;
		else 						alive <= initial_state;
	end
	
	assign out = alive;
	
endmodule

module summer #(parameter WIDTH=8) (in, out);
	input logic [WIDTH-1:0] in;
	output int out;
	
	int i;
	
	always_comb begin
		out = in[0];
		for (i = 1; i < WIDTH; i++) begin
			out = out + in[i];
		end
	end
endmodule

module life_logic (alive, neighbor_count, next_gen);
	input  logic	alive;
	input  int		neighbor_count;
	output logic	next_gen;
	
	always_comb begin
		case (neighbor_count)
			2: next_gen = alive;
			3: next_gen = 1'b1;
			default: next_gen = 1'b0;
		endcase
	end
endmodule

module MovingDot_testbench();
	logic 			clk, clk_slow, reset, game_on, select;
	logic [3:0] 	move;
	logic [15:0]	RedPixels, GrnPixels;
	
	MovingDot dut (.clk, .clk_slow, .reset, .game_on, .move, .select, .RedPixels, .GrnPixels);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		forever #(CLOCK_PERIOD/2) clk_slow <= ~clk_slow;
	end
	
	integer i;
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		
		for (i = 0; i < 8; i++) begin
			move <= 4'b0001; 	@(posedge clk);
			move <= 4'b0000; 	@(posedge clk);
		end
		
		for (i = 0; i < 8; i++) begin
			move <= 4'b0100; 	@(posedge clk);
			move <= 4'b0000; 	@(posedge clk);
		end
		
		select <= 1; 			@(posedge clk);
		select <= 0; 			@(posedge clk);
		
		move <= 4'b0001; 		@(posedge clk);
		select <= 1; 			@(posedge clk);
		select <= 0; 			@(posedge clk);
		
		move <= 4'b0001; 		@(posedge clk);
		select <= 1; 			@(posedge clk);
		select <= 0; 			@(posedge clk);
		
		game_on <= 1; 			@(posedge clk);
		
		for (i = 0; i < 5; i++) begin
			@(posedge clk);
		end
	end

endmodule

module moving_dot_testbench();
	logic 		clk, reset;
	logic [3:0] move, row, col;
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		
		for (i = 0; i < 16; i++) begin
			move = i; @(posedge clk);
		end
		
		for (i = 0; i < 17; i++) begin
			move = 4'b0001; @(posedge clk);
		end
	end
endmodule

module toggly_bit_testbench();
	logic clk, reset, select, active, out;
	
	toggly_bit dut (.clk, .reset, .select, .active, .out);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	
	initial begin
		reset <= 1; @(posedge clk); @(posedge clk);
		reset <= 0; @(posedge clk); @(posedge clk);
		
		for (i = 0; i < 4; i++) begin
			{select, active} = i; @(posedge clk);
		end
	end
endmodule

module celly_testbench();
	logic clk_slow, reset, game_on, initial_state, out;
	logic [7:0] neighbors;
	
	celly dut(.clk_slow, .reset, .game_on, .initial_state, .neighbors, .out);
	
	int i;
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk_slow <= 0;
		forever #(CLOCK_PERIOD/2) clk_slow <= ~clk_slow;
	end
	initial begin
		reset <= 1; @(posedge clk_slow);
		reset <= 0; @(posedge clk_slow);
		
		for (i = 0; i < 1024; i++) begin
			{game_on, initial_state, neighbors} = i; @(posedge clk_slow);
		end
	end
endmodule

module summer_testbench();
	logic [7:0] in;
	int 			out;
	
	summer dut (.in, .out);
	
	int i;
	
	initial begin
		for (i = 0; i < 256; i++) begin
			in = i; #10;
		end
	end
	
endmodule

module life_logic_testbench();
	logic alive, next_gen;
	int	 neighbor_count;
	
	life_logic dut (.alive, .neighbor_count, .next_gen);
	
	int i;
	
	initial begin
		for (i = 0; i < 32; i++) begin
			{alive, neighbor_count} = i; #10;
		end
	end
endmodule
