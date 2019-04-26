module HardwareTesting(clock, reset, dataOut, dataOut2, flag_long_out, look_now_out, clk_out);
	
	input clock, reset;
	output dataOut, dataOut2; 
	output flag_long_out, look_now_out;
	output clk_out;
	reg flag_long_in; 
	reg look_now_in; 
	wire dataInNext; 
	reg[9:0] postResetTimer;
	reg[9:0] byte_address;
	wire[7:0] byte_stream_in;
	wire[9:0] K_size; 

		
	input_stream input_stream_inst (
		.address ( byte_address),
		.clock (clock),
		.q (byte_stream_in)
	);

	TurboInterleaver TB_inst(
		.clk(clock), 
		.reset_async(reset),
		.dataIn(byte_stream_in),
		.dataInNext(dataInNext),
		.dataOut(dataOut),
		.dataOut2(dataOut2),
		.flag_long_in(flag_long_in), 
		.look_now_in(look_now_in),
		.flag_long_out(flag_long_out), 
		.look_now_out(look_now_out));
	
	//Change flag_long_in based on the test case K size
	
	assign clk_out = clock; 
	assign K_size = flag_long_in ? 10'b1100000000 : 10'b0000010000100; 
	initial 
	begin
		postResetTimer = 10'd0;
		byte_address = 10'd0;
		flag_long_in = 1'b0; 
		look_now_in = 1'b0;
	end
	
	always @(posedge clock)
	begin 
	if (reset == 1'b0) begin
		postResetTimer = 10'd0;
		byte_address = 10'd0;
		look_now_in = 1'b0;
		flag_long_in = 1'b0;
	end else begin
		if (postResetTimer < 10'd500) begin // wait for button release for 10us
			postResetTimer = postResetTimer + 10'd1;
			look_now_in = 1'b0;
			flag_long_in = 1'b0;
		end else begin
			if(dataInNext == 1'b1) begin
				if (byte_address >= K_size) begin
					look_now_in = 1'b0;
					flag_long_in = 1'b0;
				end else begin
					byte_address = byte_address+ 10'd1;
					look_now_in = 1'b1;
					flag_long_in = 1'b0;
				end
			end else begin
				look_now_in = 1'b1;
				flag_long_in = 1'b0;
			end
		end
	end
	
	end 

endmodule