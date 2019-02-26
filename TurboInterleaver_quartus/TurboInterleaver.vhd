library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver is
	port (
		clk, reset_async:			in std_logic;
		dataBufferIn:				in std_logic;
		dataBufferOut:				out std_logic;
		
		flag_long_in, look_now_in: in std_logic;
		flag_long_out, look_now_out: out std_logic
	);
end TurboInterleaver;

architecture arch1 of TurboInterleaver is

	component TurboInterleaver_StateMachine
		PORT (
			Clock		: IN		STD_LOGIC;
			Reset		: IN		STD_LOGIC;
			init		: IN		STD_LOGIC;
			u           : in        STD_LOGIC;
			compute_enable  : in    STD_LOGIC;
			CRC_out		: out   	STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END component;
	
	component TurboInterleaver_Interleaver
		PORT (

			clk, reset_async:			in std_logic;

			dataBufferIn_short:			in std_logic_vector(1055 DOWNTO 0);
			dataBufferIn_long:			in std_logic_vector(6143 DOWNTO 0);
			dataBufferOut_short:		out std_logic_vector(1055 DOWNTO 0);
			dataBufferOut_long:			out std_logic_vector(6143 DOWNTO 0)
		);
	END component;

begin

	

end arch1;