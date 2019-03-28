library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver is
	port (
		clk, reset_async:			in std_logic;
		dataIn:						in std_logic;	-- bit serial stream in (buffer built in)
		dataOut:					out std_logic; 	-- bit serial stream interleaved out (buffered)
		dataOut2:					out std_logic;  -- bit serial stream non-interleaved out (buffered)
		
		flag_long_in, look_now_in: 	in std_logic; 	-- to be asserted at beginning of data input
		flag_long_out, look_now_out:out std_logic 	-- will be asserted 1 clock before the start of data output
	);
end TurboInterleaver;

architecture dummy of TurboInterleaver is
begin

end dummy;