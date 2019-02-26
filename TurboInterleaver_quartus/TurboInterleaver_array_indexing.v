module array_indexing(input_buffer, data_rdy, clock, flag_long, output_buffer, look_now);


	input  clock, data_rdy, flag_long;
	//output reg out;
	output reg look_now; 
	
	
	reg [12:0] counter; 
	input [6143:0] input_buffer;
	output reg [6143:0] output_buffer;
	reg [12:0] new_index; 
	
	wire [12:0] K;
	wire [9:0] f1, f2; 
	assign K = flag_long ? 13'd6144 : 13'd1056; 
	assign f1 = flag_long ?  10'd263 :10'd17;
	assign f2 = flag_long ?  10'd480  :10'd56;
	
	
	always @( posedge clock) begin
		
		if (data_rdy == 1'b1) begin
			if (counter>= K) begin
				counter<=1'b0;
				look_now <= 1'b1; 
			end 
			else begin
				look_now <= 1'b0; 
				new_index <= (f1 * counter + f2* counter*counter) % K;
				output_buffer[new_index] <= input_buffer[counter]; 			
				counter <= counter+1; 
			
			end
		end
		
		else 
			counter <= 1'b0;	
		
	
	end 











endmodule 