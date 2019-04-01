
library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver_Interleaver is
	port (
		clk, reset_async:			in std_logic;
		flag_long:					in std_logic;

		dataBufferIn:			in std_logic_vector(6143 DOWNTO 0);
		dataBufferOut:			out std_logic_vector(6143 DOWNTO 0)
	);
end TurboInterleaver_Interleaver;

architecture arch1 of TurboInterleaver_Interleaver is

begin