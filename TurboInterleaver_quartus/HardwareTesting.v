module HardwareTesting(clock, notreset,
										dataOut, dataOut2, flag_long_out, look_now_out, clk_out, not_clk_out,
										byte_stream_in, dataInNext, flag_long_in, look_now_in,
										switchInputs);
	
	input clock, notreset;
	wire 	reset;
	output dataOut, dataOut2; 
	output flag_long_out, look_now_out;
	output clk_out, not_clk_out;
	output reg flag_long_in, look_now_in; 
	output dataInNext; 
	reg[9:0] postResetTimer;
	reg[9:0] byte_address;
	output reg[7:0] byte_stream_in;
	wire[9:0] K_size; 
	input [9:0] switchInputs;

//		
//	input_stream_1 input_stream_inst(
//		.address (byte_address),
//		.clock (clock),
//		.q (byte_stream_in)
//	);

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
	
	initial 
	begin
		postResetTimer = 10'd0;
		byte_address = 10'd0;
		flag_long_in = 1'b0; 
		look_now_in = 1'b1;
		byte_stream_in = 8'd0;
	end
	
		
	assign clk_out = clock; 
	assign not_clk_out = ~clock;
	assign K_size = flag_long_in ? 10'b1100000000 : 10'b00010000100; 
	assign reset = ~notreset;
	
//	always @(posedge clock)
//	begin 
//		flag_long_in = 1'b1;
//		if (reset == 1'b1) begin
//			 byte_address = 10'd0;
//		end else begin
//			if (byte_address < K_size) begin
//				look_now_in = 1'b1;
//				if(dataInNext == 1'b1) begin
//					byte_address = byte_address + 10'd1;
//				end
//			end else begin
//				look_now_in = 1'b0; 
//			end
//		end
//		
//		if (byte_address < 10'd10) begin
//			byte_stream_in = 8'b11111111;
//		end else begin
//			byte_stream_in = 8'b0;
//		end
//	end 
	
 always @(posedge clock)
	begin 
		if (reset == 1'b1) begin
			postResetTimer = 10'd0;
			byte_address = 10'd0;
			look_now_in = 1'b0;
			flag_long_in = switchInputs[9];
		end 
		else begin
			if (postResetTimer < 10'd499) begin // wait for button release for 10us
				postResetTimer = postResetTimer + 10'd1;
				look_now_in = 1'b0;
				byte_address = 10'b1111111111;
			end else begin
				if (byte_address < (K_size-1) || byte_address==10'b1111111111) begin
					look_now_in = 1'b1;
					if(dataInNext == 1'b1) begin
						byte_address = byte_address+ 10'd1;
					end
				end else if (byte_address == (K_size-1)) begin
					look_now_in = 1'b0;
					if(dataInNext == 1'b1) begin
						byte_address = byte_address+ 10'd1;
					end
				end else begin 
					look_now_in = 1'b0;
				end
			end
		end
		
		if (~switchInputs[8]) begin
			if (byte_address == 10'd0) begin // yes, this 1 is intentional
				byte_stream_in = switchInputs[7:0];
			end else begin
				byte_stream_in = 8'b0;
			end
		end else begin
			if (byte_address == (K_size-10'b1)) begin
				byte_stream_in = switchInputs[7:0];
			end else begin
				byte_stream_in = 8'b0;
			end
		end
	end 
  
endmodule 