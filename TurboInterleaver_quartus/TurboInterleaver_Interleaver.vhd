library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver_Interleaver is
	port (
		clk, reset_async:			in std_logic;

		dataBufferIn_short:			in std_logic_vector(1055 DOWNTO 0);
		dataBufferIn_long:			in std_logic_vector(6143 DOWNTO 0);
		dataBufferOut_short:		out std_logic_vector(1055 DOWNTO 0);
		dataBufferOut_long:			out std_logic_vector(6143 DOWNTO 0)
	);
end TurboInterleaver_Interleaver;

architecture arch1 of TurboInterleaver_Interleaver is

begin

	dataBufferOut_short = 

end arch1;