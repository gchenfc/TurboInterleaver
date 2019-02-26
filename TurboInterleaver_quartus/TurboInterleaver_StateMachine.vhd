library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver_StateMachine is
	port (
		clk, reset_async:			in std_logic;
		dataBufferIn:				in std_logic;
		dataBufferOut:				out std_logic;
		
		flag_long_in, look_now_in: in std_logic;
		flag_long_out, look_now_out: out std_logic;
		beginInterleave:			out std_logic
	);
end TurboInterleaver_StateMachine;

architecture arch1 of TurboInterleaver_StateMachine is

begin

	

end arch1;