library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver is
	port (
		clk, reset_async:			in std_logic;
		dataBufferIn:				in std_logic_vector(6143 DOWNTO 0);
		dataBufferOut:				out std_logic_vector(6143 DOWNTO 0);
		
		flag_long_in, look_now_in: in std_logic;
		flag_long_out, look_now_out: out std_logic
	);
end TurboInterleaver;

architecture arch1 of TurboInterleaver is

	component TurboInterleaver_StateMachine
		PORT (
			clk, reset_async:			in std_logic;
			dataBufferIn:				in std_logic_vector(6143 DOWNTO 0);
			dataBufferOut:				out std_logic_vector(6143 DOWNTO 0);
			
			flag_long_in, look_now_in: in std_logic;
			flag_long_out, look_now_out: out std_logic;
			beginInterleave:			out std_logic
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

	signal beginInterleave:	std_logic;
	signal dataBufferIn_short, dataBufferOut_short:	std_logic_vector(1055 DOWNTO 0);
	signal dataBufferIn_long, dataBufferOut_long:	std_logic_vector(6143 DOWNTO 0);

begin
	
	statemachine_inst: TurboInterleaver_StateMachine PORT MAP (
			clk => clk,
			reset_async => reset_async,
			dataBufferIn 	=> dataBufferIn,
			dataBufferOut 	=> dataBufferOut,
			flag_long_in 	=> flag_long_in,
			look_now_in 	=> look_now_in,
			flag_long_out 	=> flag_long_out,
			look_now_out 	=> look_now_out,
			beginInterleave => beginInterleave
		);

	interleaver_inst : TurboInterleaver_Interleaver PORT MAP (
			  clk    => clk,
			  reset_async    => reset_async,
			  dataBufferIn_short 	=> dataBufferIn_short,
			  dataBufferIn_long 	=> dataBufferIn_long,
			  dataBufferOut_short	=> dataBufferOut_short,
			  dataBufferOut_long 	=> dataBufferOut_long
		);

end arch1;