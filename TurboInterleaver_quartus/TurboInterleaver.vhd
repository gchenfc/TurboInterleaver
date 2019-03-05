library ieee;
use ieee.std_logic_1164.all;

entity TurboInterleaver is
	port (
		clk, reset_async:			in std_logic;
		dataIn:				in std_logic;
		dataOut:				out std_logic;
		
		flag_long_in, look_now_in: in std_logic;
		flag_long_out, look_now_out: out std_logic
	);
end TurboInterleaver;

architecture arch1 of TurboInterleaver is

	component TurboInterleaver_StateMachine
		PORT (
			clock_sig		:	in std_logic;
			reset_sig		:	in std_logic;
			in_looknow_sig	:	in std_logic;
			in_long_sig		:	in std_logic;
			debug_out_reset_sig		:	out std_logic;
			debug_out_enable_sig		:	out std_logic;
			debug_out_perform_sig	:	out std_logic;
			out_looknow_sig: 	out std_logic;
			out_long_sig	:	out std_logic;
			debug_out_q				:	out std_logic_vector (12 downto 0)
		);
	END component;
	
	component TurboInterleaver_Interleaver
		PORT (

			clk, reset_async:			in std_logic;
			flag_long:					in std_logic;

			dataBufferIn:			in std_logic_vector(6143 DOWNTO 0);
			dataBufferOut:			out std_logic_vector(6143 DOWNTO 0)
		);
	END component;
	
	component TurboInterleaver_shiftRegIn
		PORT
		(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			shiftin		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (6143 DOWNTO 0)
		);
	end component;
	component TurboInterleaver_shiftRegOut
		PORT
		(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			data		: IN STD_LOGIC_VECTOR (6143 DOWNTO 0);
			load		: IN STD_LOGIC ;
			shiftout		: OUT STD_LOGIC 
		);
	end component;
	
	-- FSM
	signal clock_sig		:	std_logic;
	signal reset_sig		:	std_logic;
	signal in_looknow_sig	:	std_logic;
	signal in_long_sig		:	std_logic;
	signal debug_out_reset_sig		:	std_logic;
	signal debug_out_enable_sig		:	std_logic;
	signal debug_out_perform_sig	:	std_logic;
	signal out_looknow_sig: 	std_logic;
	signal out_long_sig	:	std_logic;
	signal debug_out_q				:	std_logic_vector (12 downto 0);
	
	-- shiftRegIn
	signal aclr_shiftRegIn	:	std_logic;
	signal shiftin_shiftRegIn	:	std_logic;
	signal q_shiftRegIn	:	std_logic_vector(6143 DOWNTO 0);

	-- interleaver
	signal flag_long_interleaver : std_logic;
	signal dataBufferIn : std_logic_vector(6143 DOWNTO 0);
	signal dataBufferOut : std_logic_vector(6143 DOWNTO 0);

	-- shiftRegOut
	signal aclr_shiftRegOut	: std_logic;
	signal data_shiftRegOut	: std_logic_vector(6143 DOWNTO 0);
	signal load_shiftRegOut	: std_logic;
	signal shiftout_shiftRegOut	: std_logic;

begin
	
	statemachine_inst: TurboInterleaver_StateMachine PORT MAP (
			clock_sig => clk		,
			reset_sig => reset_sig		,
			in_looknow_sig => in_looknow_sig	,
			in_long_sig => in_long_sig		,
			debug_out_reset_sig => debug_out_reset_sig		,
			debug_out_enable_sig => debug_out_enable_sig		,
			debug_out_perform_sig => debug_out_perform_sig	,
			out_looknow_sig => out_looknow_sig	,
			out_long_sig => out_long_sig	,
			debug_out_q => debug_out_q	
		);

	shiftRegIn_inst: TurboInterleaver_shiftRegIn PORT MAP (
				clock => clk,
				aclr => aclr_shiftRegIn,
				shiftin => shiftin_shiftRegIn,
				q => q_shiftRegIn
		);

	interleaver_inst : TurboInterleaver_Interleaver PORT MAP (
			  clk    => clk,
			  reset_async    => reset_async,
			  flag_long => flag_long_interleaver,
			  dataBufferIn 	=> dataBufferIn,
			  dataBufferOut 	=> dataBufferOut
		);

	shiftRegOut_inst: TurboInterleaver_shiftRegOut PORT MAP (
				clock => clk,
				aclr => aclr_shiftRegOut,
				data => data_shiftRegOut,
				load => load_shiftRegOut,
				shiftout => shiftout_shiftRegOut
		);

	in_looknow_sig <= look_now_in;
	in_long_sig <= flag_long_in;
	look_now_out <= out_looknow_sig;
	flag_long_out <= out_long_sig;

	shiftin_shiftRegIn <= dataIn;
	flag_long_interleaver <= flag_long_in;
	dataBufferIn(6143 DOWNTO 0) <= q_shiftRegIn(6143 DOWNTO 0);
	data_shiftRegOut(6143 DOWNTO 0) <= dataBufferOut(6143 DOWNTO 0);
	load_shiftRegOut <= out_looknow_sig;
	dataOut <= shiftout_shiftRegOut;

	reset_sig <= reset_async;
	aclr_shiftRegIn <= reset_async;
	aclr_shiftRegOut <= reset_async;

end arch1;