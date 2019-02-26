library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver_StateMachine is
	port (
		clk, reset_async:			in std_logic;
		dataBufferIn:				in std_logic;
		dataBufferOut:				out std_logic;
		
		flag_long_in, look_now_in: in std_logic;
		flag_long_out, look_now_out: out std_logic
	);
end TurboInterleaver_StateMachine;

architecture arch1 of TurboInterleaver_StateMachine is

	component crc16r1
		PORT (
			Clock		: IN		STD_LOGIC;
			Reset		: IN		STD_LOGIC;
			init		: IN		STD_LOGIC;
			u           : in        STD_LOGIC;
			compute_enable  : in    STD_LOGIC;
			CRC_out		: out   	STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END component;
	
	component CRCcheckFSM
		PORT (
			clk:							in std_logic;
			reset_async:				in std_logic;
			receive_data_valid:		in std_logic;
			CRC_out:						in std_logic_vector (15 DOWNTO 0);
			init, compute_enable:	out std_logic;
			check_result:				out std_logic;
			look_now:					out std_logic
		);
	END component;
	

	signal CRC_out_sig:							std_logic_vector (15 DOWNTO 0);
	signal init_sig, compute_enable_sig:	std_logic;

begin

	

end arch1;