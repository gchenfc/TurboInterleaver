`timescale 1 ns/ 100 ps

module TurboInterleaver_tb2();

	reg clock; 
	reg reset;
	reg dataIn;
	reg flag_long_in, look_now_in;
	wire look_now_out, flag_long_out;
	wire dataOut;
	
	reg [7:0] address;
	wire [7:0] q_in; //both outputs from the mif files 
	wire [7:0] q_expected; //both outputs from the mif files
	reg bit_stream_in;
	reg [12:0] counter;
	
	
	
	TurboInterleaver interleaver (
	
		.clk(clock), .reset_async(reset), 
		.dataIn(dataIn),
		.dataOut(dataOut),
		.flag_long_in(flag_long_in), 
		.look_now_in(look_now_in),
		.flag_long_out(flag_long_out), 
		.look_now_out(look_now_out)
	);

	
	input_test input_test1( .address(address),.clock(clock), .q(q_in));


	
	output_test output_test1(
		.address(address),
		.clock(clock),
		.q(q_expected)
	);


	always 
		#10 clock = ~clock;
		
		assign flag_long_out = flag_long_in;
	
	initial 
		begin 
			$display($time, "<<Starting the Simulation>>");
			clock = 1'b0; 
			address = 8'b0;
			flag_long_in = 1'b0;
			bit_stream_in = 1'b1;
			counter=13'b0;
			//$display("First = %b", q_expected[4]);
			$display("end initial");

		
		end 
		
	
	
	always@(posedge clock) 
		begin
			address = counter/8;
			if (bit_stream_in) 
			begin
				if (counter < 1056)
					begin
					counter = counter + 1;
					dataIn = q_in[counter%8];
					end
				else
					begin
					counter = 13'b0;
					bit_stream_in = 1'b1; 
					end ;
			end;
			if (~bit_stream_in) 
				begin
				if (counter < 1056) 
				begin
					counter = counter + 1;
				end 
			end 

		
		end
		



endmodule 