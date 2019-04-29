`timescale 1 ns / 100 ps 
module HardwareTesting_tb();
	reg notreset, clock;
	wire dataOut, dataOut2, flag_long_out, look_now_out, clk_out, not_clk_out;
	wire [7:0] byte_stream;
	
	wire dataInNext, flag_long_in, look_now_in;
	reg [9:0] switchInputs;
	
	HardwareTesting HT_inst(clock, notreset, dataOut, dataOut2, flag_long_out, look_now_out, clk_out, not_clk_out, byte_stream,
								 dataInNext, flag_long_in, look_now_in,
										switchInputs);
 always
 #10 clock = ~clock; // every ten nanoseconds invert

initial
 begin
	clock = 1'b0;
	notreset = 1'b0;
	
	switchInputs = 10'b1000000001;
	#200 notreset = 1'b1;
	
	#500000 $stop;
 end 


endmodule 