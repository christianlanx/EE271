module UPC(discounted, stolen, u, p, c, m);
	output logic discounted, stolen;
	input logic u, p, c, m;
	
	assign discounted = (u&p)|(p&c)|(u&c);
	assign stolen = (~p&~c&~m)|(u&~p&~m);
endmodule
	
module UPC_testbench();
	logic u, p, c, m;
	logic discounted, stolen;
	
	UPC dut(.discounted, .stolen, .u, .p, .c, .m);
	
	integer i;
	initial begin
		for (i = 0; i < 14; i++) begin
			{u, p, c, m} = i; #10;
		end
	end
endmodule