module SetPattern(clk, reset, red, move, initialPattern, RedPixels, GrnPixels);
	input  logic clk, reset, red;
	input  logic [3:0] move;			// the bits of move are up, down, left and right
	output logic [15:0][15:0] initialPattern, RedPixels, GrnPixels;

	integer y, x;
	
	initial begin
		initialPattern = 0;
	end

	always_comb begin
		case (move)
			4'b0001:	begin
				GrnPixels[y][x] = 0;
				
			end;
			4'b0010:	;
			4'b0100:	;
			4'b1000: ;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			initialPattern <= 0;
			y = 0;
			x = 0;
		end
		else begin
			if (red) initialPattern[y][x] <= 1;
		end
		RedPixels <= initialPattern;
		GrnPixels[y][x] <= 1;
	end 
endmodule